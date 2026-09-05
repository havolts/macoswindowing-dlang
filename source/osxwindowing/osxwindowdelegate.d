module osxwindowing.osxwindowdelegate;

import cocoa;
import std.stdio;
import core.attribute : selector;

extern(Objective-C)
extern class OSXWindowDelegate : NSObject, NSWindowDelegate
{
    override void windowWillClose(NSNotification notification) @selector("windowWillClose:")
    {
        writeln("Window will close");
    }
}
