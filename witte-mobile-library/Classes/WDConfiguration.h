//
//  WDConfiguration.h
//  witte-mobile-library
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * The tenant id used with the Tapkey backend.
 */
FOUNDATION_EXPORT NSString* const WD_TENANT_ID;

/**
 * The id token type used to authenticate with the Tapkey backend.
 */
FOUNDATION_EXPORT NSString* const WD_IP_ID;

/**
 * The Bluetooth LE service UUID of a flinkey box.
 */
FOUNDATION_EXPORT NSString* const WD_BLE_SERIVCE_UUID;

@interface WDConfiguration : NSObject

- (instancetype)initWithCustomerId:(NSInteger)customerId
                            sdkKey:(NSString*)sdkKey
                   subscriptionKey:(NSString*)subscriptionKey;

/**
 * The tenant id used with the Tapkey backend.
 */
@property (readonly) NSString* tenantId;

/**
 * The id token type used to authenticate with the Tapkey backend.
 */
@property (readonly) NSString* ipId;

/**
 * The Bluetooth LE service UUID of a flinkey box.
 */
@property (readonly) NSString* bleServiceUuid;
@property (readonly) NSInteger witteCustomerId;
@property (readonly) NSString* witteSdkKey;
@property (readonly) NSString* witteSubscriptionKey;

@end

NS_ASSUME_NONNULL_END
