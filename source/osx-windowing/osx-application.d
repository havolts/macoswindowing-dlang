module osxwindowing.osxapplication;

import cocoa;
import osxwindowing.osxwindow;

class OSXApplication
{
    // Start Application via Instantiation
    // Add a Window

    NSApplication nsApp;
    OSXWindow[] windows;

    this()
    {
        nsApp = NSApplication.sharedApplication;
        nsApp.setActivationPolicy(NSApplicationActivationPolicy.NSApplicationActivationPolicyRegular);
        nsApp.activateIgnoringOtherApps(true);
    }

    void CreateWindow(int width, int height, string title)
    {
        windows ~= new OSXWindow(width, height, title);
    }
}
