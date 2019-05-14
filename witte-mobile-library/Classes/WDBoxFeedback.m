//
//  WDBoxFeedback.m
//  witte-mobile-library
//

#import "WDBoxFeedback.h"
#import "WDByteUtils.h"

@implementation WDBoxFeedback

- (instancetype)initWithResponseData:(NSData*)responseData {
    self = [super init];
    if(self) {
        
        if(responseData && responseData.length == 10){
            
            const char* bytes = (const char*)[responseData bytes];
            if([WDByteUtils isBitSetWithByteValue:bytes[6] bitIndex:0]){
                _boxState = WDBoxStateDrawerOpen;
            }
            else if([WDByteUtils isBitSetWithByteValue:bytes[1] bitIndex:7]){
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

@end
