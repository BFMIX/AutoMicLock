import Cocoa

func resizeImage(image: NSImage, width: CGFloat, height: CGFloat) -> NSBitmapImageRep? {
    let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(width), pixelsHigh: Int(height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)
    
    NSGraphicsContext.saveGraphicsState()
    if let rep = rep {
        NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
        image.draw(in: NSRect(x: 0, y: 0, width: width, height: height))
    }
    NSGraphicsContext.restoreGraphicsState()
    return rep
}

func savePNG(rep: NSBitmapImageRep, path: String) {
    if let pngData = rep.representation(using: .png, properties: [:]) {
        try? pngData.write(to: URL(fileURLWithPath: path))
    }
}

// Generate App Icon Set
let iconsetPath = "Sources/Assets.xcassets/AppIcon.appiconset"
try? FileManager.default.removeItem(atPath: iconsetPath) // Clean old icons
try? FileManager.default.createDirectory(atPath: iconsetPath, withIntermediateDirectories: true)

let sourceIconPath = "AutoMicLock-icon.png"
guard let sourceImage = NSImage(contentsOfFile: sourceIconPath) else {
    print("Error: Could not find AutoMicLock-icon.png at root.")
    exit(1)
}

let sizes = [(16, 1), (16, 2), (32, 1), (32, 2), (128, 1), (128, 2), (256, 1), (256, 2), (512, 1), (512, 2)]
var contents = """
{
  "images" : [

"""

for (index, (baseSize, scale)) in sizes.enumerated() {
    let filename = "icon_\(baseSize)x\(baseSize)\(scale == 2 ? "@2x" : "").png"
    let fullPath = "\(iconsetPath)/\(filename)"
    if let rep = resizeImage(image: sourceImage, width: CGFloat(baseSize * scale), height: CGFloat(baseSize * scale)) {
        savePNG(rep: rep, path: fullPath)
    }
    
    contents += """
    {
      "filename" : "\(filename)",
      "idiom" : "mac",
      "scale" : "\(scale)x",
      "size" : "\(baseSize)x\(baseSize)"
    }\(index == sizes.count - 1 ? "" : ",")

"""
}

contents += """
  ],
  "info" : {
    "author" : "xcode",
    "version" : 1
  }
}
"""
try? contents.write(to: URL(fileURLWithPath: "\(iconsetPath)/Contents.json"), atomically: true, encoding: .utf8)


// Generate DMG Background
func createDMGBackground() -> NSBitmapImageRep {
    let width: Int = 700
    let height: Int = 400
    let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: width, pixelsHigh: height, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
    
    NSGraphicsContext.saveGraphicsState()
    NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
    let ctx = NSGraphicsContext.current?.cgContext
    
    let h = CGFloat(height)
    let w = CGFloat(width)
    
    // Bright vibrant gradient matching the UI
    let colors = [
        NSColor(red: 0.1, green: 0.4, blue: 0.9, alpha: 1.0).cgColor, // Bright Blue
        NSColor(red: 0.8, green: 0.2, blue: 0.6, alpha: 1.0).cgColor  // Bright Pink
    ] as CFArray
    let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0, 1])!
    
    // Draw gradient
    ctx?.drawLinearGradient(gradient, start: CGPoint(x: w, y: 0), end: CGPoint(x: 0, y: h), options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
    
    let centerX: CGFloat = w / 2.0
    
    // Title with rounded, heavy font
    let title = "Auto MicLock"
    let font = NSFont.systemFont(ofSize: 36, weight: .heavy)
    let fontDescriptor = font.fontDescriptor.withDesign(.rounded) ?? font.fontDescriptor
    let roundedFont = NSFont(descriptor: fontDescriptor, size: 36) ?? font
    
    let attrs: [NSAttributedString.Key: Any] = [
        .font: roundedFont,
        .foregroundColor: NSColor.white
    ]
    let titleSize = title.size(withAttributes: attrs)
    title.draw(at: NSPoint(x: centerX - (titleSize.width / 2), y: 310), withAttributes: attrs)
    
    // Subtitle
    let sub = "Drag to Applications to install"
    let subAttrs: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: 16, weight: .medium),
        .foregroundColor: NSColor.white.withAlphaComponent(0.9)
    ]
    let subSize = sub.size(withAttributes: subAttrs)
    sub.draw(at: NSPoint(x: centerX - (subSize.width / 2), y: 280), withAttributes: subAttrs)
    
    // Cartoon Arrow (between App at X=150 and Applications at X=350 -> Center is X=250)
    // In CoreGraphics, Y=0 is bottom. Icons are at Y=200 from top -> Y=200 from bottom.
    let arrowConfig = NSImage.SymbolConfiguration(pointSize: 30, weight: .bold)
    if let arrowImage = NSImage(systemSymbolName: "arrowshape.right.fill", accessibilityDescription: nil)?.withSymbolConfiguration(arrowConfig) {
        arrowImage.lockFocus()
        NSColor.white.set()
        let imageRect = NSRect(origin: .zero, size: arrowImage.size)
        imageRect.fill(using: .sourceAtop)
        arrowImage.unlockFocus()
        
        let arrowW = arrowImage.size.width * 1.5 // stretch width
        let arrowH = arrowImage.size.height
        let arrowTargetRect = NSRect(x: 250 - (arrowW / 2), y: 200 - (arrowH / 2), width: arrowW, height: arrowH)
        arrowImage.draw(in: arrowTargetRect)
    }
    
    // Hint text at the bottom
    let hint = "If blocked by Gatekeeper, see the included Installation.pdf"
    let hintFont = NSFont.systemFont(ofSize: 14, weight: .regular)
    let hintAttrs: [NSAttributedString.Key: Any] = [
        .font: hintFont,
        .foregroundColor: NSColor.white.withAlphaComponent(0.8)
    ]
    let hintSize = hint.size(withAttributes: hintAttrs)
    // Place near bottom
    hint.draw(at: NSPoint(x: centerX - (hintSize.width / 2), y: 40), withAttributes: hintAttrs)
    
    NSGraphicsContext.restoreGraphicsState()
    return rep
}

try? FileManager.default.createDirectory(atPath: "build", withIntermediateDirectories: true)
savePNG(rep: createDMGBackground(), path: "build/dmg_background.png")
print("Assets generated successfully.")
