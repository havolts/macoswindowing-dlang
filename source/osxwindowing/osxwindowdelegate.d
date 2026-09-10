module osxwindowing.osxwindowdelegate;
import cocoa;
import std.stdio;
import core.attribute : selector;

extern(Objective-C)
extern class OSXWindowDelegate : NSObject, NSWindowDelegate
{
    bool terminateApp = false;
    override static OSXWindowDelegate alloc() @selector("alloc");
    override OSXWindowDelegate init() @selector("init");
    void windowWillClose(NSNotification notification) @selector("windowWillClose:")
    {
        if(terminateApp) NSApplication.sharedApplication().terminate(this);
    }
}
