//
//  WDBoxFeedback.h
//  witte-mobile-library
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WDBoxState) {
    WDBoxStateUndefined,
    WDBoxStateLocked,
    WDBoxStateUnlocked,
    WDBoxStateDrawerOpen
};

@interface WDBoxFeedback : NSObject

- (instancetype)initWithResponseData:(NSData*)responseData;

- (double) getBatteryStateOfChargeWithBoxId:(NSString*)boxId;

@property (readonly) WDBoxState boxState;
@property (readonly) char* boxFeedbackBytes;
@end

NS_ASSUME_NONNULL_END
