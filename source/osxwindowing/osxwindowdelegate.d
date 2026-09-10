module osxwindowing.osxwindowdelegate;
import cocoa;
import std.stdio;
import core.attribute : selector;

extern(Objective-C)
extern class OSXWindowDelegate : NSObject, NSWindowDelegate
{
    // Bind to the Objective-C property
    bool terminateApp() @selector("terminateApp");
    void terminateApp(bool) @selector("setTerminateApp:");

    override static OSXWindowDelegate alloc() @selector("alloc");
    override OSXWindowDelegate init() @selector("init");

    // Declaration only, no body
    void windowWillClose(NSNotification notification) @selector("windowWillClose:");
}
