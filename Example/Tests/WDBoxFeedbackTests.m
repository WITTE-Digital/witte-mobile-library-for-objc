//
//  WDBoxFeedbackTests.m
//  wittemobilelibrary_Tests
//

#import <Foundation/Foundation.h>
#import "WDBoxFeedback.h"
#import "WDByteUtils.h"

NSString* const BoxFeedbackLocked01 = @"4C420FFA5008003700D8";
NSString* const BoxFeedbackLocked02 = @"4F420FFA5308003700D9";
NSString* const BoxFeedbackLocked03 = @"4C420FFA4E08003800D9";
NSString* const BoxFeedbackLocked04 = @"4D420FFA4E08003700D8";
NSString* const BoxFeedbackLocked05 = @"4A420FFA4C08003600D8";

NSString* const BoxFeedbackUnlocked01 = @"4FC10FF0590000362AD9";
NSString* const BoxFeedbackUnlocked02 = @"52C20FF0550000352BDA";
NSString* const BoxFeedbackUnlocked03 = @"4FC20FF05500003529D9";
NSString* const BoxFeedbackUnlocked04 = @"4FC30FF0570000362AD9";
NSString* const BoxFeedbackUnlocked05 = @"4CC30FF05700003628D9";

NSString* const BoxFeedbackDrawerOpen01 = @"0DC10FFF0019030000B0";
NSString* const BoxFeedbackDrawerOpen02 = @"0DC30FFF0019030000B0";
NSString* const BoxFeedbackDrawerOpen03 = @"0DC20FFF0019030000AF";
NSString* const BoxFeedbackDrawerOpen04 = @"0DC30FFF0019030000AF";
NSString* const BoxFeedbackDrawerOpen05 = @"0DC20FFF0019030000B0";

NSString* const BoxV3FeedbackBattery01 = @"FF3D34003200EC28FF00";
double const BoxV3FeedbackBattery01Result = 93.65;
NSString* const BoxV3FeedbackBattery02 = @"FFBD34003200F029FF00";
double const BoxV3FeedbackBattery02Result = 95.24;
NSString* const BoxV3FeedbackBattery03 = @"FF3D33003300E01DFF00";
double const BoxV3FeedbackBattery03Result = 88.89;
NSString* const BoxV3FeedbackBattery04 = @"FFBC34003300EC2AFF00";
double const BoxV3FeedbackBattery04Result = 93.65;
NSString* const BoxV3FeedbackBattery05 = @"FF3C34003600F01BFF00";
double const BoxV3FeedbackBattery05Result = 95.24;
NSString* const BoxV3FeedbackBattery06 = @"FFBC34003100F028FF00";
double const BoxV3FeedbackBattery06Result = 95.24;
NSString* const BoxV3FeedbackBattery07 = @"FF3D34003100F81DFF00";
double const BoxV3FeedbackBattery07Result = 98.41;
NSString* const BoxV3FeedbackBattery08 = @"FFBD34003100F828FF00";
double const BoxV3FeedbackBattery08Result = 98.41;

SpecBegin(BoxFeedback)

describe(@"Box feedback indicating locked state", ^{
    
    it(@"box is closed", ^{
        NSArray* array = [[NSArray alloc]initWithObjects:
                          BoxFeedbackLocked01,
                          BoxFeedbackLocked02,
                          BoxFeedbackLocked03,
                          BoxFeedbackLocked04,
                          BoxFeedbackLocked05,
                          nil];
        
        for(id str in array) {
            NSData* data = [WDByteUtils toByteArray:str];
            WDBoxFeedback* boxFeedback = [[WDBoxFeedback alloc]initWithResponseData:data];
            expect(boxFeedback.boxState).to.equal(WDBoxStateLocked);
        }
    });
});

describe(@"Box feedback indicating unlocked state", ^{
    
    it(@"box is opened", ^{
        NSArray* array = [[NSArray alloc]initWithObjects:
                          BoxFeedbackUnlocked01,
                          BoxFeedbackUnlocked02,
                          BoxFeedbackUnlocked03,
                          BoxFeedbackUnlocked04,
                          BoxFeedbackUnlocked05,
                          nil];
        
        for(id str in array) {
            NSData* data = [WDByteUtils toByteArray:str];
            WDBoxFeedback* boxFeedback = [[WDBoxFeedback alloc]initWithResponseData:data];
            expect(boxFeedback.boxState).to.equal(WDBoxStateUnlocked);
        }
    });
});

describe(@"Box feedback indicating open drawer", ^{
    
    it(@"box drawer is open", ^{
        NSArray* array = [[NSArray alloc]initWithObjects:
                          BoxFeedbackDrawerOpen01,
                          BoxFeedbackDrawerOpen02,
                          BoxFeedbackDrawerOpen03,
                          BoxFeedbackDrawerOpen04,
                          BoxFeedbackDrawerOpen05,
                          nil];
        
        for(id str in array) {
            NSData* data = [WDByteUtils toByteArray:str];
            WDBoxFeedback* boxFeedback = [[WDBoxFeedback alloc]initWithResponseData:data];
            expect(boxFeedback.boxState).to.equal(WDBoxStateDrawerOpen);
        }
    });
});

describe(@"Calculate battery state of charge from box feedback", ^{
    it(@"battery stage of charge", ^{
        NSArray* array = [[NSArray alloc]initWithObjects:
                          BoxV3FeedbackBattery01,
                          BoxV3FeedbackBattery02,
                          BoxV3FeedbackBattery03,
                          BoxV3FeedbackBattery04,
                          BoxV3FeedbackBattery05,
                          BoxV3FeedbackBattery06,
                          BoxV3FeedbackBattery07,
                          BoxV3FeedbackBattery08,
                          nil];
        
        double expectedResults[8] = {
            BoxV3FeedbackBattery01Result,
            BoxV3FeedbackBattery02Result,
            BoxV3FeedbackBattery03Result,
            BoxV3FeedbackBattery04Result,
            BoxV3FeedbackBattery05Result,
            BoxV3FeedbackBattery06Result,
            BoxV3FeedbackBattery07Result,
            BoxV3FeedbackBattery08Result,
        };
        
        for(int i = 0; i < 8; i++) {
            NSData* data = [WDByteUtils toByteArray:array[i]];
            WDBoxFeedback* boxFeedback = [[WDBoxFeedback alloc]initWithResponseData:data];
            double bsc = [boxFeedback getBatteryStateOfChargeWithBoxId:@"C3-00-00-00"];
            
            int result = bsc * 100;
            int expectedResult = expectedResults[i] * 100;
            expect(result).to.equal(expectedResult);
        }
    });
});

SpecEnd
