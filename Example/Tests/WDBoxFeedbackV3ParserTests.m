//
//  WDBoxFeedbackV3ParserTests.m
//  witte-mobile-library_Tests
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
//#import "WDBoxFeedbackV3Parser.h"
#import "WDBoxFeedback.h"
#import "WDByteUtils.h"

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

@interface WDBoxFeedbackV3ParserTests : XCTestCase
@end

@implementation WDBoxFeedbackV3ParserTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testBatteryStateOfCharge {
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
}

@end
