//
//  WDBoxFeedbackV3ParserTests.m
//  witte-mobile-library_Tests
//

#import <Foundation/Foundation.h>
#import <XCTest/XCTest.h>
#import "WDBoxFeedbackV3Parser.h"
#import "WDBoxFeedbackV3.h"
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

- (void)testParseValidDataCase01 {
    WDBoxFeedbackV3* expected = [[WDBoxFeedbackV3 alloc]init];
    expected.batteryStateOfCharge = 89;
    expected.batteryIsCharging = NO;
    expected.batteryChargerIsConnected = NO;
    expected.drawerState = NO;
    expected.drawerAccessibility = YES;
    
    uint8_t dataBytes[] = {
        0x01, // [00]
        0x00, // [01]
        0x02, // [02]
        0x01, // [03]
        0x00, // [04]
        0x01, // [05]
        0x03, // [06]
        0x59, // [07]
        0x43, // [08]
        0x40, // [09]
        0x00, // [10]
        0x00  // [11]
    };
    NSData *data = [NSData dataWithBytes:dataBytes length:sizeof(dataBytes)];
    
    WDBoxFeedbackV3* result = [[WDBoxFeedbackV3 alloc]init];
    [WDBoxFeedbackV3Parser parseData:data boxFeedback:&result];
    
    expect(result.batteryStateOfCharge).equal(result.batteryStateOfCharge);
    expect(result.batteryIsCharging).equal(result.batteryIsCharging);
    expect(result.batteryChargerIsConnected).equal(result.batteryChargerIsConnected);
    expect(result.drawerState).equal(result.drawerState);
    expect(result.drawerAccessibility).equal(result.drawerAccessibility);
    expect(result.nfcTag1Uid).equal(result.nfcTag1Uid);
    expect(result.nfcTag2Uid).equal(result.nfcTag2Uid);
    expect(result.nfcTag3Uid).equal(result.nfcTag3Uid);
}

- (void)testParseValidDataCase02 {
    WDBoxFeedbackV3* expected = [[WDBoxFeedbackV3 alloc]init];
    expected.batteryStateOfCharge = 92;
    expected.batteryIsCharging = NO;
    expected.batteryChargerIsConnected = NO;
    expected.drawerState = NO;
    expected.drawerAccessibility = NO;
    
    uint8_t dataBytes[] = {
        0x01, // [00]
        0x00, // [01]
        0x02, // [02]
        0x01, // [03]
        0x00, // [04]
        0x01, // [05]
        0x03, // [06]
        0x5c, // [07]
        0x43, // [08]
        0x00, // [09]
        0x00, // [10]
        0x00  // [11]
    };
    
    NSData *data = [NSData dataWithBytes:dataBytes length:sizeof(dataBytes)];
    
    WDBoxFeedbackV3* result = [[WDBoxFeedbackV3 alloc]init];
    [WDBoxFeedbackV3Parser parseData:data boxFeedback:&result];
    
    expect(result.batteryStateOfCharge).equal(result.batteryStateOfCharge);
    expect(result.batteryIsCharging).equal(result.batteryIsCharging);
    expect(result.batteryChargerIsConnected).equal(result.batteryChargerIsConnected);
    expect(result.drawerState).equal(result.drawerState);
    expect(result.drawerAccessibility).equal(result.drawerAccessibility);
    expect(result.nfcTag1Uid).equal(result.nfcTag1Uid);
    expect(result.nfcTag2Uid).equal(result.nfcTag2Uid);
    expect(result.nfcTag3Uid).equal(result.nfcTag3Uid);
}

- (void)testParseValidDataCase04 {
    WDBoxFeedbackV3* expected = [[WDBoxFeedbackV3 alloc]init];
    expected.batteryStateOfCharge = 91;
    expected.batteryIsCharging = NO;
    expected.batteryChargerIsConnected = NO;
    expected.drawerState = NO;
    expected.drawerAccessibility = NO;
    
    uint8_t dataBytes[] = {
        0x01, // [00]
        0x00, // [01]
        0x01, // [02]
        0x03, // [03]
        0x5b, // [04]
        0x43, // [05]
        0x00  // [06]
    };
    NSData *data = [NSData dataWithBytes:dataBytes length:sizeof(dataBytes)];
    
    WDBoxFeedbackV3* result = [[WDBoxFeedbackV3 alloc]init];
    [WDBoxFeedbackV3Parser parseData:data boxFeedback:&result];
    
    expect(result.batteryStateOfCharge).equal(result.batteryStateOfCharge);
    expect(result.batteryIsCharging).equal(result.batteryIsCharging);
    expect(result.batteryChargerIsConnected).equal(result.batteryChargerIsConnected);
    expect(result.drawerState).equal(result.drawerState);
    expect(result.drawerAccessibility).equal(result.drawerAccessibility);
    expect(result.nfcTag1Uid).equal(result.nfcTag1Uid);
    expect(result.nfcTag2Uid).equal(result.nfcTag2Uid);
    expect(result.nfcTag3Uid).equal(result.nfcTag3Uid);
}

- (void)testParseValidDataCase01With2NfcTags {
    WDBoxFeedbackV3* expected = [[WDBoxFeedbackV3 alloc]init];
    expected.batteryStateOfCharge = 86;
    expected.batteryIsCharging = NO;
    expected.batteryChargerIsConnected = NO;
    expected.drawerState = NO;
    expected.drawerAccessibility = YES;
    expected.nfcTag1Uid = @"041858DA181390";
    expected.nfcTag2Uid = @"04758ECAF26281";
    
    NSData* data = [WDByteUtils toByteArray:@"AQACAQADEAcEGFjaGBOQBwR1jsryYoEBA1ZBQA=="];
    WDBoxFeedbackV3* result = [[WDBoxFeedbackV3 alloc]init];
    [WDBoxFeedbackV3Parser parseData:data boxFeedback:&result];
    
    expect(result.batteryStateOfCharge).equal(result.batteryStateOfCharge);
    expect(result.batteryIsCharging).equal(result.batteryIsCharging);
    expect(result.batteryChargerIsConnected).equal(result.batteryChargerIsConnected);
    expect(result.drawerState).equal(result.drawerState);
    expect(result.drawerAccessibility).equal(result.drawerAccessibility);
    expect(result.nfcTag1Uid).equal(result.nfcTag1Uid);
    expect(result.nfcTag2Uid).equal(result.nfcTag2Uid);
    expect(result.nfcTag3Uid).equal(result.nfcTag3Uid);
}
@end
