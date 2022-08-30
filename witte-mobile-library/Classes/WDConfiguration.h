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

/**
 * The Bluetooth LE advertising format for flinkey box 2.4.
 */
FOUNDATION_EXPORT NSString* const WD_BLE_ADVERTISING_FORMAT_V1;

/**
 * The Bluetooth LE advertising format for flinkey box 3.3.
 */
FOUNDATION_EXPORT int const WD_BLE_ADVERTISING_FORMAT_V2;

NS_ASSUME_NONNULL_END
