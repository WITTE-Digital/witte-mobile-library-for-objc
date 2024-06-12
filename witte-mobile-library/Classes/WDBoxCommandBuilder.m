//
// WDBoxCommandBuilder.m
// witte-mobile-library
//

#import "WDBoxCommandBuilder.h"
#import "WDBoxCommandConfig.h"
#import "WDCRC8.h"

// Constants
const uint8_t BitMask0 = 1 << 0;
const uint8_t BitMask1 = 1 << 1;
const uint8_t BitMask2 = 1 << 2;
const uint8_t BitMask3 = 1 << 3;
const uint8_t BitMask4 = 1 << 4;
const uint8_t BitMask5 = 1 << 5;
const uint8_t BitMask6 = 1 << 6;
const uint8_t BitMask7 = 1 << 7;
const NSUInteger CommandLength = 16;
const short CommandVersion = 1;

@implementation WDBoxCommandBuilder
+ (NSData *)build:(WDBoxCommandConfig *)config withTimeMillis:(int64_t) totalMillis {
    NSMutableData *bytes = [NSMutableData dataWithLength:CommandLength];

    // Byte 01: Data Byte Count (DBC)
    ((uint8_t *)[bytes mutableBytes])[1] = (uint8_t)[bytes length];

    // Bytes 02 - 03: Data structure version number (DVER)
    uint16_t version = CommandVersion;
    [bytes replaceBytesInRange:NSMakeRange(2, 2) withBytes:&version];

    // Bytes 04 - 11: UTS
    
    [bytes replaceBytesInRange:NSMakeRange(4, 8) withBytes:&totalMillis];

    // Byte 12: Command Byte
    uint8_t commandByte = 0x00;
    if (config.lockBox) {
        commandByte |= BitMask0;
    }
    if (config.unlockBox) {
        commandByte |= BitMask1;
    }
    if (config.lockCar) {
        commandByte |= BitMask2;
    }
    if (config.unlockCar) {
        commandByte |= BitMask3;
    }
    if (config.status) {
        commandByte |= BitMask4;
    }
    if (config.readNfc) {
        commandByte |= BitMask5;
    }
    if (config.factoryReset) {
        commandByte |= BitMask6;
    }

    ((uint8_t *)[bytes mutableBytes])[12] = commandByte;

    // Bytes 13-15: Spares
    // Already set to zero by default in NSMutableData

    // Byte 00: Checksum
    uint8_t checksum = [WDCRC8 computeChecksum:[bytes subdataWithRange:NSMakeRange(1, 15)]];
    ((uint8_t *)[bytes mutableBytes])[0] = checksum;

    return bytes;
}

+ (NSData *)build:(WDBoxCommandConfig *)config {
    int64_t totalMillis = (int64_t)([[NSDate date] timeIntervalSince1970] * 1000.0);
    return [WDBoxCommandBuilder build:config withTimeMillis:totalMillis];
}

+ (NSData *)buildUnlockCarUnlockBox {
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.unlockBox = YES;
    config.unlockCar = YES;
    config.status = YES;
    return [self build:config];
}

+ (NSData *)buildUnlockCarUnlockBox:(BOOL)readNfc {
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.unlockBox = YES;
    config.unlockCar = YES;
    config.status = YES;
    if (readNfc) {
        config.readNfc = YES;
    }
    return [self build:config];
}

+ (NSData *)buildUnlockCarLockBox {
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.lockBox = YES;
    config.unlockCar = YES;
    config.status = YES;
    return [self build:config];
}

+ (NSData *)buildUnlockCarLockBox:(BOOL)readNfc {
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.lockBox = YES;
    config.unlockCar = YES;
    config.status = YES;
    if (readNfc) {
        config.readNfc = YES;
    }
    return [self build:config];
}

+ (NSData *)buildLockCarLockBox {
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.lockBox = YES;
    config.lockCar = YES;
    config.status = YES;
    return [self build:config];
}

+ (NSData *)buildLockCarLockBox:(BOOL)readNfc {
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.lockBox = YES;
    config.lockCar = YES;
    config.status = YES;
    if (readNfc) {
        config.readNfc = YES;
    }
    return [self build:config];
}

+ (NSData *)buildStatus {
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.status = YES;
    return [self build:config];
}

+ (NSData *)buildStatus:(BOOL)readNfc {
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.status = YES;
    if (readNfc) {
        config.readNfc = YES;
    }
    return [self build:config];
}

+ (NSData *)buildReadNfc {
    WDBoxCommandConfig *config = [[WDBoxCommandConfig alloc] init];
    config.readNfc = YES;
    return [self build:config];
}

@end
