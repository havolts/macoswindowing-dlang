#import <Cocoa/Cocoa.h>

@interface OSXWindowDelegate : NSObject <NSWindowDelegate>
@property (assign) BOOL terminateApp;
@end

@implementation OSXWindowDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        _terminateApp = NO;
    }
    return self;
}

- (void)windowWillClose:(NSNotification *)notification {
    if (self.terminateApp) {
        [[NSApplication sharedApplication] terminate:self];
    }
}
@end
