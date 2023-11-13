# Get Formatted Code Only For AutoHotKey Scripts

## Overview

This script, written in AutoHotKey, allows you to quickly format your code and copy it to the clipboard. It provides a simple graphical user interface (GUI) for pasting code, formatting it, and copying the formatted code to the clipboard. Additionally, it supports keyboard shortcuts for a more seamless experience.

## How to Use

### Using the GUI

1. **Paste Code for Formatting:**
   - Use (Ctrl+V) to paste your code into the provided text area.

2. **Format Code:**
   - Click the "Format Code" button or use the shortcut (Alt+Ctrl+Shift+F).
   - The formatted code will be displayed in the adjacent text area.

3. **Copy to Clipboard:**
   - Click the "Copy to Clipboard" button or use the shortcut (Alt+Ctrl+Shift+C).
   - If the code is already formatted and not in the clipboard, it will be copied.

4. **Exiting the Application:**
   - Click the close button on the GUI or use the shortcut (Alt+L) to exit the application.

### Using Keyboard Shortcuts

- **Format Code:**
  - If the GUI is open, press (Alt+Ctrl+Shift+F) to format the code immediately.

- **Copy to Clipboard:**
  - If the GUI is open, press (Alt+Ctrl+Shift+C) to copy the formatted code to the clipboard.

- **Exiting the Application:**
  - If the GUI is open, press (Alt+L) to exit the application.

### Advanced Tip

- If the GUI is already open, you can select the code with (Ctrl+A) and then immediately press (Alt+Ctrl+Shift+F) to format it without interacting with the GUI directly.

## Note

- The script utilizes an external AutoHotKey script (`ahk format script.ahk`) for formatting.
- Ensure that the formatted code is already in the clipboard before attempting to copy it again.

## Dependencies

- AutoHotKey
