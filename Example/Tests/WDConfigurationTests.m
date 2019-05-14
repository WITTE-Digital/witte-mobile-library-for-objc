//
//  WDConfigurationTests.m
//  witte-mobile-library_Tests
//

#import <Foundation/Foundation.h>
#import "WDConfiguration.h"

NSInteger const TestCustomerId = 1;
NSString* const TestSdkKey = @"the-customers-sdk-key";
NSString* const TestSubscriptionKey = @"the-customers-subscription-key";

SpecBegin(Configuration)

describe(@"Configuration", ^{
    
    it(@"success", ^{
        
        WDConfiguration* configuration =
            [[WDConfiguration alloc]initWithCustomerId:TestCustomerId
                                                sdkKey:TestSdkKey
                                       subscriptionKey:TestSubscriptionKey];

        expect(configuration.witteCustomerId).to.equal(TestCustomerId);
        expect(configuration.witteSdkKey).to.equal(TestSdkKey);
        expect(configuration.witteSubscriptionKey).to.equal(TestSubscriptionKey);
        expect(configuration.ipId).to.equal(WD_IP_ID);
        expect(configuration.tenantId).to.equal(WD_TENANT_ID);
        expect(configuration.bleServiceUuid).to.equal(WD_BLE_SERIVCE_UUID);
    });
});

SpecEnd
