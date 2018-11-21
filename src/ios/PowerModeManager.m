#import "PowerModeManager.h"
#import <Cordova/CDVAvailability.h>

@implementation PowerModeManager
@synthesize callbackId;

- (void)isLowPowerEnabled:(CDVInvokedUrlCommand *)command {
	CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:[self getPowerModeInfo]];
	[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void)start:(CDVInvokedUrlCommand*)command
{
	self.callbackId = command.callbackId;
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(didChangePowerMode:)
												 name:NSProcessInfoPowerStateDidChangeNotification
											   object:nil];
}

-(NSDictionary *)getPowerModeInfo {
	return @{@"isLowPowerEnabled": ([[NSProcessInfo processInfo] isLowPowerModeEnabled]) ? @"true" : @"false"};
}

- (void)stop:(CDVInvokedUrlCommand*)command {
	if (self.callbackId) {
		CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:[self getPowerModeInfo]];
		[result setKeepCallbackAsBool:NO];
		[self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
	}
	self.callbackId = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NSProcessInfoPowerStateDidChangeNotification object:nil];
}

- (void)didChangePowerMode:(NSNotification *)notification {
	if (!self.callbackId) return;
	NSDictionary *powerModeData = [self getPowerModeInfo];
	CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:powerModeData];
	[self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
}

@end
