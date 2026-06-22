//source/objc/window.m
#import <Cocoa/Cocoa.h>

NSMutableArray *windows;
static NSMutableDictionary *terminateObservers;

void initializeApplication() {
    [NSApplication sharedApplication];
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
    windows = [NSMutableArray array];
}

void activateApplication() {
    [NSApp activateIgnoringOtherApps:YES];
}

void initializeMultithreading() {
    [NSThread detachNewThreadSelector:@selector(dummyThreadEntry) toTarget:[NSObject class] withObject:nil];
}

@interface NSObject (DummyThread)
+ (void)dummyThreadEntry;
@end

@implementation NSObject (DummyThread)
+ (void)dummyThreadEntry {
    [NSThread exit];
}
@end

NSWindow* createWindow(float width, float height, const char *cTitle) {
    NSRect frame = NSMakeRect(0, 0, width, height);
    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable;
    NSWindow *window = [[NSWindow alloc] initWithContentRect:frame
                                                  styleMask:style
                                                    backing:NSBackingStoreBuffered
                                                      defer:NO];
    NSString *objcTitle = [NSString stringWithUTF8String:cTitle];
    [window setTitle:objcTitle];
    [window makeKeyAndOrderFront:nil];
    [windows addObject:window];
    return window;
}

@interface CustomWindow : NSWindow
@end

@implementation CustomWindow

- (instancetype)initWithFrame:(NSRect)frame {
    self = [super initWithContentRect:frame styleMask:(NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskResizable)
                            backing:NSBackingStoreBuffered defer:NO];
    if (self) {
        int width = frame.size.width;
        int height = frame.size.height;
    }
    return self;
}

@end

@interface WindowDelegate : NSObject <NSWindowDelegate>
@end

@implementation WindowDelegate
- (void)windowWillClose:(NSNotification *)notification {
    NSWindow *window = notification.object;
    [windows removeObject:window];
}
@end

void setWindowDelegate(NSWindow *window) {
    WindowDelegate *windowDelegate = [[WindowDelegate alloc] init];
    [window setDelegate:windowDelegate];
}

void setupWindow(NSWindow *window) {
    setWindowDelegate(window);
}

void doTerminateOnCloseC(NSWindow *window, BOOL shouldTerminate) {
    if (!terminateObservers) {
        terminateObservers = [NSMutableDictionary dictionary];
    }

    if (shouldTerminate == YES) {
        id observer = [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowWillCloseNotification
                                                                        object:window
                                                                         queue:nil
                                                                    usingBlock:^(NSNotification * _Nonnull note) {
            [NSApp terminate:nil];
        }];
        terminateObservers[[NSValue valueWithNonretainedObject:window]] = observer;
    } else {
        id observer = terminateObservers[[NSValue valueWithNonretainedObject:window]];
        if (observer) {
            [[NSNotificationCenter defaultCenter] removeObserver:observer
                                                            name:NSWindowWillCloseNotification
                                                          object:window];
            [terminateObservers removeObjectForKey:[NSValue valueWithNonretainedObject:window]];
        }
    }
}

void pollEvents() {
    @autoreleasepool {
        NSEvent *event = [NSApp nextEventMatchingMask:NSEventMaskAny
                                            untilDate:[NSDate distantPast]
                                               inMode:NSDefaultRunLoopMode
                                              dequeue:YES];
        if (event) {
            [NSApp sendEvent:event];
        }
        [NSApp updateWindows];
    }
}
