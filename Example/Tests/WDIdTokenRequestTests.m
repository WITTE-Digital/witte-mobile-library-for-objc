//
//  WDIdTokenRequestTests.m
//  witte-mobile-library_Tests
//

#import <Foundation/Foundation.h>
#import "WDConfiguration.h"
#import "WDIdTokenRequest.h"

SpecBegin(IdTokenRequest)

describe(@"execute request", ^{
    
    it(@"success", ^{
        
        WDConfiguration* configuration = [[WDConfiguration alloc] initWithCustomerId:1 sdkKey:@"sdk-key" subscriptionKey:@"sub-key"];
        WDIdTokenRequest* idTokenRequest = [[WDIdTokenRequest alloc]init];
        NSString* idToken = [idTokenRequest executeWithConfiguration:configuration
                                                           andUserId:1];
        
        expect(idToken).notTo.beNil();
    });
});


SpecEnd
