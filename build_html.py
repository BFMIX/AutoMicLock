import base64
import os

def img_to_b64(path):
    with open(path, "rb") as f:
        return "data:image/png;base64," + base64.b64encode(f.read()).decode('utf-8')

html = f"""<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Installation - AutoMicLock</title>
    <style>
        @page {{
            size: A4;
            margin: 1cm;
        }}
        body {{
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background-color: white;
            color: #333;
            max-width: 800px;
            margin: 0 auto;
            padding: 0;
            line-height: 1.4;
            font-size: 14px;
        }}
        h1 {{
            font-size: 24px;
            text-align: center;
            margin-bottom: 20px;
            color: #1d1d1f;
        }}
        .step {{
            margin-bottom: 20px;
            page-break-inside: avoid;
        }}
        .step h2 {{
            font-size: 16px;
            color: #007aff;
            margin: 0 0 5px 0;
        }}
        .step p {{
            margin: 0 0 10px 0;
        }}
        img {{
            display: block;
            max-width: 100%;
            max-height: 300px; /* Increased to 300px as requested */
            margin: 0 auto;
            border-radius: 4px;
            box-shadow: 0 1px 4px rgba(0,0,0,0.1);
        }}
        .note {{
            background: #f2f2f7;
            padding: 10px 15px;
            border-radius: 6px;
            font-size: 12px;
            color: #666;
            margin-top: 15px;
        }}
    </style>
</head>
<body>
    <h1>How to allow AutoMicLock to open</h1>
    
    <div class="step">
        <h2>Step 1: The blocked message</h2>
        <p>On the first launch, Apple blocks the application because it is from an "unidentified developer". Simply click <strong>Done</strong> or <strong>OK</strong>.</p>
        <img src="{img_to_b64('docs/tutorial/step1.png')}" alt="Step 1">
    </div>

    <div class="step">
        <h2>Step 2: System Settings</h2>
        <p>Open your Mac's <strong>System Settings</strong>, then go to the <strong>Privacy & Security</strong> tab. Scroll down, and you will see a message regarding AutoMicLock. Click the <strong>Open Anyway</strong> button.</p>
        <img src="{img_to_b64('docs/tutorial/step2.png')}" alt="Step 2">
    </div>

    <div class="step">
        <h2>Step 3: Confirm opening</h2>
        <p>A final confirmation window will appear. Enter your system password if prompted, then click <strong>Open</strong>.</p>
        <img src="{img_to_b64('docs/tutorial/step3.png')}" alt="Step 3">
    </div>

    <div class="note">
        <strong>Note:</strong> This process is only required the very first time you launch the app.
    </div>
</body>
</html>"""

with open("Installation.html", "w") as f:
    f.write(html)
