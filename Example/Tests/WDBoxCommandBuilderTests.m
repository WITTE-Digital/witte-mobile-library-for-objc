//
//  WDBoxCommandBuilderTests.m
//  witte-mobile-library_Tests
//

#import <XCTest/XCTest.h>
#import "WDBoxCommandBuilder.h"

@interface WDBoxCommandBuilderTests : XCTestCase
@end

@implementation WDBoxCommandBuilderTests

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

- (void)testBuildStatus {
    NSData *command = [WDBoxCommandBuilder buildStatus];
    XCTAssertNotNil(command, @"The command should not be nil.");
}

@end
