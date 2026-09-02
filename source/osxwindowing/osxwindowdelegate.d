module osxwindowing.osxwindowdelegate;

import cocoa;

extern(Objective-C)
extern class OSXWindowDelegate : NSObject, NSWindowDelegate
{
    static OSXWindowDelegate alloc() @selector("alloc");
    OSXWindowDelegate init() @selector("init");
    void windowWillClose(NSNotification notification) @selector("windowWillClose:");
}
