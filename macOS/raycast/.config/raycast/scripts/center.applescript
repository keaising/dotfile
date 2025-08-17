#!/usr/bin/env osascript -l JavaScript

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title center window
// @raycast.mode compact

// Optional parameters:
// @raycast.icon 🎯

// Documentation:
// @raycast.author Taiga
// @raycast.authorURL https://raycast.com/keaising


ObjC.import('Cocoa');

/**
 * Get the front application and its first window
 * @returns {Object} Object containing frontApp and frontWindow, or null if no window found
 */
function getFrontAppAndWindow() {
  const se = Application('System Events');
  const frontApp = se.processes.whose({ frontmost: true })[0];
  const appName = frontApp.name();
  
  const frontWindows = frontApp.windows();
  if (frontWindows.length === 0) {
    console.log("No windows found for front application");
    return null;
  }
  
  return {
    frontApp: frontApp,
    frontWindow: frontWindows[0],
    windowCount: frontWindows.length
  };
}

/**
 * Find the screen that contains the given window
 * @param {Object} window - The window object
 * @returns {Object} The screen object that contains the window
 */
function getScreenForWindow(window) {
  const windowFrame = window.position();
  const windowX = windowFrame[0];
  const windowY = windowFrame[1];
  
  const screens = $.NSScreen.screens;
  let targetScreen = $.NSScreen.mainScreen; // fallback to main screen
  
  for (let i = 0; i < screens.count; i++) {
    const screen = screens.objectAtIndex(i);
    const screenFrame = screen.frame;
    const screenX = screenFrame.origin.x;
    const screenY = screenFrame.origin.y;
    const screenW = screenFrame.size.width;
    const screenH = screenFrame.size.height;
    
    // Check if window is within this screen bounds
    if (windowX >= screenX && windowX < (screenX + screenW) &&
        windowY >= screenY && windowY < (screenY + screenH)) {
      targetScreen = screen;
      break;
    }
  }
  
  return targetScreen;
}

/**
 * Calculate new window dimensions and position
 * @param {Object} screen - The target screen object
 * @param {number} widthRatio - Width ratio (default 0.8 for 80% width)
 * @param {number} heightRatio - Height ratio (default 0.8 for 80% height)
 * @returns {Object} Object containing newW, newH, newX, newY
 */
function calculateWindowBounds(screen, widthRatio = 0.8, heightRatio = 0.95) {
  const screenFrame = screen.frame;
  const visibleFrame = screen.visibleFrame; 
  
  const availableW = visibleFrame.size.width;
  const availableH = visibleFrame.size.height;
  const availableX = visibleFrame.origin.x;

  const newW = Math.round(availableW * widthRatio); // 80% width
  const newH = Math.round(availableH * heightRatio); // 100% available height
  const newX = availableX + Math.round((availableW - newW) / 2); // center horizontally
  
  const menuBarHeight = screenFrame.size.height - visibleFrame.size.height - visibleFrame.origin.y;
  const newY = menuBarHeight + Math.round((availableH - newH) / 2); // center vertically

  return { newW, newH, newX, newY };
}

/**
 * Resize the given window to the specified bounds
 * @param {Object} window - The window object to resize
 * @param {Object} bounds - Object containing newW, newH, newX, newY
 * @returns {boolean} True if successful, false otherwise
 */
function resizeWindow(window, bounds) {
  try {
    window.position = [bounds.newX, bounds.newY];
    window.size = [bounds.newW, bounds.newH];
    console.log("Window resized successfully");
    return true;
  } catch (error) {
    console.log("Error manipulating window:", error.message);
    return false;
  }
}

/**
 * Main function that orchestrates the window resizing
 */
function main() {
  // Get front app and window
  const appInfo = getFrontAppAndWindow();
  if (!appInfo) {
    return;
  }

  // Find the screen containing the window
  const targetScreen = getScreenForWindow(appInfo.frontWindow);

  // Calculate new window bounds
  const bounds = calculateWindowBounds(targetScreen);
  console.log(bounds.newW, bounds.newH, bounds.newX, bounds.newY);

  // Resize the window
  resizeWindow(appInfo.frontWindow, bounds);
}

// Execute main function
main();