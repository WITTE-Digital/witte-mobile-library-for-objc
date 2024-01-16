//
// WDBoxFeedback.m
// witte-mobile-library
//

#import "WDBoxFeedback.h"
#import "WDByteUtils.h"
#import "WDBoxIdConverter.h"

@implementation WDBoxFeedback

- (instancetype)initWithResponseData:(NSData*)responseData {
    self = [super init];
    if(self) {
        if(responseData && responseData.length == 10){
            _boxFeedbackBytes = (char*)[responseData bytes];
            if([WDByteUtils isBitSetWithByteValue:_boxFeedbackBytes[6] bitIndex:0]){
                _boxState = WDBoxStateDrawerOpen;
            }
            else if([WDByteUtils isBitSetWithByteValue:_boxFeedbackBytes[1] bitIndex:7]){
                _boxState = WDBoxStateUnlocked;
            }
            else {
                _boxState = WDBoxStateLocked;
            }
        }
        else {
            _boxState = WDBoxStateUndefined;
        }
    }
    
    return self;
}

- (double)getBatteryStateOfChargeWithBoxId:(NSString *)boxId {
    double batteryStateOfCharge = -1.0;
    
    WDBoxIdConverter* boxIdConverter = [[WDBoxIdConverter alloc]init];
    if([boxIdConverter isValidBoxIdWithBoxId:boxId]) {
        if(![boxId hasPrefix:@"C1"]) {
            int v = 0;
            char byte = _boxFeedbackBytes[6];
            for(int i = 7; i >= 2; i--) {
                if([WDByteUtils isBitSetWithByteValue:byte bitIndex:i]) {
                    int digit = (1 << (i-2));
                    v += digit;
                }
            }
            
            batteryStateOfCharge = v / 63.0 * 100.0;
            batteryStateOfCharge = round(batteryStateOfCharge*100.0) / 100.0;
        }
    }
    
    return batteryStateOfCharge;
}

@end
