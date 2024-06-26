//
// WDBoxFeedbackV3.m
// witte-mobile-library
//

#import "WDBoxFeedbackV3.h"

@implementation WDBoxFeedbackV3

- (instancetype)init {
    self = [super init];
    if (self) {
        // Initialize properties with default values
        _batteryStateOfCharge = 0; // Assuming 0 as the default value
        _batteryIsCharging = NO;
        _batteryChargerIsConnected = NO;
        _drawerState = NO;
        _drawerAccessibility = NO;
        _nfcTag1Uid = nil;
        _nfcTag2Uid = nil;
        _nfcTag3Uid = nil;
    }
    return self;
}

@end
