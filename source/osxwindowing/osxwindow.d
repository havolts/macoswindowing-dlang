module osxwindowing.osxwindow;

import cocoa;
import cocoa.foundation.nsrect : NSMakeRect;
import metalkit;
import osxwindowing.osxwindowdelegate;
// Windowing for OSX

class OSXWindow
{
    NSWindow window;
    OSXWindowDelegate windowDelegate;
    string title;
    this(int width, int height, string _title)
    {
        title = _title;
        NSRect contentRect = NSMakeRect(0, 0, width, height);
        NSWindow.StyleMask style = NSWindow.StyleMask.titled | NSWindow.StyleMask.closable | NSWindow.StyleMask.resizable;
        window = NSWindow.alloc().init(contentRect, style, NSWindow.BackingStoreType.buffered, false);
        window.title = _title.ns;
        //windowDelegate = OSXWindowDelegate.alloc().init();
        //window.setDelegate(windowDelegate);
        window.makeKeyAndOrderFront(null);
    }

    void setContentView(MTKView view)
    {
        window.setContentView(view);
    }
}
