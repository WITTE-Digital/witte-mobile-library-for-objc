//
//  WDConfiguration.m
//  witte-mobile-library
//

#import "WDConfiguration.h"

NSString* const WD_TENANT_ID = @"wma";
NSString* const WD_IP_ID = @"wma.oauth";
NSString* const WD_BLE_SERIVCE_UUID = @"6e65742e-7470-6ba0-0000-060601810057";

@implementation WDConfiguration

- (instancetype)initWithCustomerId:(NSInteger)customerId
                            sdkKey:(NSString*)sdkKey
                   subscriptionKey:(NSString*)subscriptionKey {
    self = [super init];
    if(self){
        _witteCustomerId = customerId;
        _witteSdkKey = sdkKey;
        _witteSubscriptionKey = subscriptionKey;
        _tenantId = WD_TENANT_ID;
        _ipId = WD_IP_ID;
        _bleServiceUuid = WD_BLE_SERIVCE_UUID;
    }
    
    return self;
}
@end
