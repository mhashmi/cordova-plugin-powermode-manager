#import <Cordova/CDVPlugin.h>

@interface PowerModeManager : CDVPlugin {
	NSString* callbackId;
}

@property (strong) NSString* callbackId;

- (void)isLowPowerEnabled:(CDVInvokedUrlCommand *)command;
- (void)start:(CDVInvokedUrlCommand*)command;
- (void)stop:(CDVInvokedUrlCommand*)command;

@end
