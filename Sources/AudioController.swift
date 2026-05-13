import Foundation
import CoreAudio
import Combine

class AudioController: ObservableObject {
    @Published var isMicLocked: Bool = true {
        didSet {
            if isMicLocked {
                lockInternalMic()
            }
        }
    }
    
    private var propertyListenerBlock: AudioObjectPropertyListenerBlock?
    
    init() {
        setupAudioListener()
        if isMicLocked {
            lockInternalMic()
        }
    }
    
    deinit {
        removeAudioListener()
    }
    
    private func setupAudioListener() {
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioHardwarePropertyDefaultInputDevice,
            mScope: kAudioObjectPropertyScopeGlobal,
            mElement: kAudioObjectPropertyElementMain
        )
        
        let listener: AudioObjectPropertyListenerBlock = { [weak self] (inNumberAddresses, inAddresses) in
            guard let self = self else { return }
            if self.isMicLocked {
                DispatchQueue.main.async {
                    self.lockInternalMic()
                }
            }
        }
        
        let status = AudioObjectAddPropertyListenerBlock(AudioObjectID(kAudioObjectSystemObject), &address, DispatchQueue.global(qos: .background), listener)
        
        if status == noErr {
            self.propertyListenerBlock = listener
            print("Audio listener registered successfully.")
        } else {
            print("Failed to register audio listener: \(status)")
        }
    }
    
    private func removeAudioListener() {
        guard let listener = propertyListenerBlock else { return }
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioHardwarePropertyDefaultInputDevice,
            mScope: kAudioObjectPropertyScopeGlobal,
            mElement: kAudioObjectPropertyElementMain
        )
        AudioObjectRemovePropertyListenerBlock(AudioObjectID(kAudioObjectSystemObject), &address, DispatchQueue.global(qos: .background), listener)
    }
    
    private func lockInternalMic() {
        let builtinMicId = getBuiltInMicrophoneID()
        guard builtinMicId != kAudioObjectUnknown else {
            print("Could not find built-in microphone.")
            return
        }
        
        let currentMicId = getDefaultInputDeviceID()
        
        if currentMicId != builtinMicId {
            print("Switching default input back to built-in microphone.")
            setDefaultInputDevice(id: builtinMicId)
        } else {
            print("Built-in microphone is already the default.")
        }
    }
    
    private func getDefaultInputDeviceID() -> AudioDeviceID {
        var deviceId: AudioDeviceID = kAudioObjectUnknown
        var dataSize = UInt32(MemoryLayout<AudioDeviceID>.size)
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioHardwarePropertyDefaultInputDevice,
            mScope: kAudioObjectPropertyScopeGlobal,
            mElement: kAudioObjectPropertyElementMain
        )
        
        let status = AudioObjectGetPropertyData(AudioObjectID(kAudioObjectSystemObject), &address, 0, nil, &dataSize, &deviceId)
        if status != noErr {
            print("Failed to get default input device ID: \(status)")
        }
        return deviceId
    }
    
    private func setDefaultInputDevice(id: AudioDeviceID) {
        var deviceId = id
        let dataSize = UInt32(MemoryLayout<AudioDeviceID>.size)
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioHardwarePropertyDefaultInputDevice,
            mScope: kAudioObjectPropertyScopeGlobal,
            mElement: kAudioObjectPropertyElementMain
        )
        
        let status = AudioObjectSetPropertyData(AudioObjectID(kAudioObjectSystemObject), &address, 0, nil, dataSize, &deviceId)
        if status != noErr {
            print("Failed to set default input device ID: \(status)")
        }
    }
    
    private func getBuiltInMicrophoneID() -> AudioDeviceID {
        var dataSize: UInt32 = 0
        var address = AudioObjectPropertyAddress(
            mSelector: kAudioHardwarePropertyDevices,
            mScope: kAudioObjectPropertyScopeGlobal,
            mElement: kAudioObjectPropertyElementMain
        )
        
        // Get number of devices
        var status = AudioObjectGetPropertyDataSize(AudioObjectID(kAudioObjectSystemObject), &address, 0, nil, &dataSize)
        guard status == noErr else { return kAudioObjectUnknown }
        
        let deviceCount = Int(dataSize) / MemoryLayout<AudioDeviceID>.size
        var deviceIDs = [AudioDeviceID](repeating: kAudioObjectUnknown, count: deviceCount)
        
        // Get all device IDs
        status = AudioObjectGetPropertyData(AudioObjectID(kAudioObjectSystemObject), &address, 0, nil, &dataSize, &deviceIDs)
        guard status == noErr else { return kAudioObjectUnknown }
        
        for id in deviceIDs {
            // Check if device has input streams
            var streamAddress = AudioObjectPropertyAddress(
                mSelector: kAudioDevicePropertyStreams,
                mScope: kAudioDevicePropertyScopeInput,
                mElement: kAudioObjectPropertyElementMain
            )
            var streamDataSize: UInt32 = 0
            if AudioObjectGetPropertyDataSize(id, &streamAddress, 0, nil, &streamDataSize) != noErr || streamDataSize == 0 {
                continue // Not an input device
            }
            
            // Check transport type
            var transportType: UInt32 = 0
            var transportDataSize = UInt32(MemoryLayout<UInt32>.size)
            var transportAddress = AudioObjectPropertyAddress(
                mSelector: kAudioDevicePropertyTransportType,
                mScope: kAudioObjectPropertyScopeGlobal,
                mElement: kAudioObjectPropertyElementMain
            )
            
            if AudioObjectGetPropertyData(id, &transportAddress, 0, nil, &transportDataSize, &transportType) == noErr {
                if transportType == kAudioDeviceTransportTypeBuiltIn {
                    return id
                }
            }
        }
        
        return kAudioObjectUnknown
    }
}
