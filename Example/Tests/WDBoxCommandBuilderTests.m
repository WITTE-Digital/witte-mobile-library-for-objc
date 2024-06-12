//
//  WDBoxCommandBuilderTests.m
//  witte-mobile-library_Tests
//

#import <XCTest/XCTest.h>
#import "WDBoxCommandBuilder.h"
#import "WDBoxCommandConfig.h"

// Class extension to expose private methods for testing
@interface WDBoxCommandBuilder (Test)
+ (NSData *)build:(WDBoxCommandConfig *)config withTimeMillis:(int64_t) totalMillis;
@end

@interface WDBoxCommandBuilderTests : XCTestCase
@end

@implementation WDBoxCommandBuilderTests

- (NSData *)dataFromBytes:(uint8_t[])bytes length:(NSUInteger)length {
    return [NSData dataWithBytes:bytes length:length];
}

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testUnlockCarUnlockBox {
    NSData *command = [WDBoxCommandBuilder buildUnlockCarUnlockBox];
    XCTAssertNotNil(command, @"The command should not be nil.");
}

- (void)testUnlockCarLockBox {
    NSData *command = [WDBoxCommandBuilder buildUnlockCarLockBox];
    XCTAssertNotNil(command, @"The command should not be nil.");
}

- (void)testLockCarLockBox {
    NSData *command = [WDBoxCommandBuilder buildLockCarLockBox];
    XCTAssertNotNil(command, @"The command should not be nil.");
}

- (void)testBuildUnlockCarUnlockBox {
    uint8_t expectedBytes[] = {
        0x7e, 0x10, 0x01, 0x00, 0xbb, 0xb1, 0x18, 0x6a, 0x8d, 0x01, 0x00, 0x00, 0x1a, 0x00, 0x00, 0x00
    };
    NSData *expected = [self dataFromBytes:expectedBytes length:sizeof(expectedBytes)];
    
    // Actual byte array
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.unlockBox = YES;
    config.unlockCar = YES;
    config.status = YES;
    
    NSData *result = [WDBoxCommandBuilder build:config withTimeMillis:1706882019771LL];
    XCTAssertEqualObjects(expected, result);
}

- (void)testBuildUnlockCarLockBox {
    uint8_t expectedBytes[] = {
        0xc4, 0x10, 0x01, 0x00, 0xbb, 0xb1, 0x18, 0x6a, 0x8d, 0x01, 0x00, 0x00, 0x19, 0x00, 0x00, 0x00
    };
    NSData *expected = [self dataFromBytes:expectedBytes length:sizeof(expectedBytes)];
    
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.lockBox = YES;
    config.unlockCar = YES;
    config.status = YES;
    
    NSData *result = [WDBoxCommandBuilder build:config withTimeMillis:1706882019771LL];
    XCTAssertEqualObjects(expected, result);
}

- (void)testBuildLockCarLockBox {
    uint8_t expectedBytes[] = {
        0x16, 0x10, 0x01, 0x00, 0xbb, 0xb1, 0x18, 0x6a, 0x8d, 0x01, 0x00, 0x00, 0x15, 0x00, 0x00, 0x00
    };
    NSData *expected = [self dataFromBytes:expectedBytes length:sizeof(expectedBytes)];
    
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.lockBox = YES;
    config.lockCar = YES;
    config.status = YES;
    
    NSData *result = [WDBoxCommandBuilder build:config withTimeMillis:1706882019771LL];
    XCTAssertEqualObjects(expected, result);
}

- (void)testBuildStatus {
    uint8_t expectedBytes[] = {
        0xc5, 0x10, 0x01, 0x00, 0xbb, 0xb1, 0x18, 0x6a, 0x8d, 0x01, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00
    };
    NSData *expected = [self dataFromBytes:expectedBytes length:sizeof(expectedBytes)];
    
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.status = YES;
    
    NSData *result = [WDBoxCommandBuilder build:config withTimeMillis:1706882019771LL];
    XCTAssertEqualObjects(expected, result);
}

@end
