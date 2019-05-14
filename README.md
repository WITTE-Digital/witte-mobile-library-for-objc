# witte-mobile-mobile-library-for-objc

The WITTE Mobile Library for Objective-C provides additional classes and methods to further assist with the integration of the WITTE backend and the Tapkey SDK in the scope of a mobile app.

## Features
* __Configuration__: WITTE Customer ID, WITTE Subscription Key, WITTE SDK Key. 
* __flinkey Box ID conversion__: Convert flinkey Box IDs to physical lock IDs format and vice versa.
* __flinkey Box feedback interpretation__: Parse and interpret the 10 byte box feedback in order to determine if the box ahs been opened or closed. 
* __idToken retrieval__: Query a authentication token from the WITTE backend that is used to authenticate with the Tapkey backend.

## Getting Started
### Configuration
The configuration comprises customer specific configuration values required to access the WITTE backend as well as constants used in context of the Tapkey Mobile Library integration.
```objective-c
#import "WDConfiguration.h"

NSInteger const CustomerId = <your WITTE customer ID>;
NSString* const SdkKey = <your WITTE SDK Key>;
NSString* const SubscriptionKey = <your WITTE subscription key>;

WDConfiguration* configuration =
    [[WDConfiguration alloc]initWithCustomerId:TestCustomerId
                                        sdkKey:TestSdkKey
                               subscriptionKey:TestSubscriptionKey];
```
#### Constants
```objective-c
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
```

### flinkey Box ID conversion
A flinkey box is identified by a box ID or a physical Lock ID which basically is just another representation of a box ID. The box ID is actually printed on the box an consists of 4 groups of hexadecimal numbers (e.g. C1-08-F0-94). The physical lock ID is an encoded version of the box Id(e.g. BADBCPCU) which is used in the API fo the Tapkey Mobile Library. This library provides method to convert between both representations.

#### Box ID to physical lock ID
```objective-c
#import "WDBoxIdConverter.h"
#import "WDByteUtils.h"

NSString* const BoxId = @"C1-08-F0-94";

WDBoxIdConverter* converter = [[WDBoxIdConverter alloc]init];
NSString* physicalLockId = [converter toPhysicalLockIdWithBoxId:BoxId];
```

#### Physical lock ID to box ID
```objective-c
#import "WDBoxIdConverter.h"
#import "WDByteUtils.h"

NSString* const PhysicalLockId = @"BADBCPCU";

WDBoxIdConverter* converter = [[WDBoxIdConverter alloc]init];
NSString* boxId = [converter toBoxIdWithPhysicalLockId:PhysicalLockId];
```
### Box feedback interpretation
In order to determine if the box has been opened or closed one needs to evaluate the 10 byte box feedback that is part of the result of a triggerLockAsync method call. This library provides a parser for the 10 byte box feedback that allows to determine the state of the box.

```objective-c
#import "WDBoxFeedback.h"
#import "WDByteUtils.h"

NSString* const str = @"4C420FFA5008003700D8";
NSData* data = [WDByteUtils toByteArray:str];
WDBoxFeedback* boxFeedback = [[WDBoxFeedback alloc]initWithResponseData:data];

if(boxFeedback.boxState == WDBoxStateLocked) {
    // the box has been locked
}
else if(boxFeedback.boxState == WDBoxStateUnlocked) {
    // the box has been opened
}
else if(boxFeedback.boxState == WDBoxStateDrawerOpen) {
    // the drawer of the box is opened
}
```

### idToken retrieval
The idToken is a Java Web Token that is required to authenticate a single user with the Tapkey Mobile Library. This library provides a class IdTokenRequest that retrieves a idToken from the WITTE backend using provided configuration properties and a WITTE user ID.

#### IdTokenRequest with configuration object

```objective-c
#import "WDConfiguration.h"
#import "WDIdTokenRequest.h"

NSInteger const CustomerId = <your WITTE customer ID>;
NSString* const SdkKey = <your WITTE SDK Key>;
NSString* const SubscriptionKey = <your WITTE subscription key>;

WDConfiguration* configuration =
    [[WDConfiguration alloc]initWithCustomerId:TestCustomerId
                                        sdkKey:TestSdkKey
                               subscriptionKey:TestSubscriptionKey];

WDIdTokenRequest* idTokenRequest = [[WDIdTokenRequest alloc]init];
NSString* idToken = [idTokenRequest executeWithConfiguration:configuration andUserId:1];

```
