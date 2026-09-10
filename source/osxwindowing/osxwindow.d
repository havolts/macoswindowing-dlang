module osxwindowing.osxwindow;
import cocoa;
import cocoa.foundation.nsrect : NSMakeRect;
import osxwindowing.osxwindowdelegate;
import metalkit;

class OSXWindow
{
    NSWindow window;
    OSXWindowDelegate windowDelegate;
    string title;
    int width, height;

    void terminateApp(bool terminate)
    {
        windowDelegate.terminateApp = terminate;
    }
    bool terminateApp()
    {
        return windowDelegate.terminateApp;
    }

    this(int _width, int _height, string _title)
    {
        title = _title;
        width = _width;
        height = _height;
        NSRect contentRect = NSMakeRect(0, 0, width, height);
        NSWindow.StyleMask style = NSWindow.StyleMask.titled | NSWindow.StyleMask.closable | NSWindow.StyleMask.resizable;
        window = NSWindow.alloc().init(contentRect, style, NSWindow.BackingStoreType.buffered, false);
        window.title = _title.ns;

        windowDelegate = OSXWindowDelegate.alloc().init();
        window.setDelegate(windowDelegate);

        window.makeKeyAndOrderFront(null);
    }

    void setContentView(MTKView view)
    {
        window.setContentView(view);
    }
}
