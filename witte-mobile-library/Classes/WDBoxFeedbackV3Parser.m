//
// WDBoxFeedbackV3Parser.m
// witte-mobile-library
//

#import "WDBoxFeedbackV3Parser.h"
#import "WDBoxFeedbackV3.h"

// Constants for parsing logic
static const int LegacyBoxFeedbackLength = 10;
static const int ResponseHeaderLength = 2;
static const int GroupHeaderLength = 2;

@implementation WDBoxFeedbackV3Parser

+ (BOOL)parseData:(NSData *)data boxFeedback:(WDBoxFeedbackV3 **)boxFeedback {
    *boxFeedback = nil;
    
    // Check for null input array
    if (!data || [data length] == 0) {
        return NO;
    }
    
    // Check valid length, excluding legacy box feedback length
    if ((ResponseHeaderLength + GroupHeaderLength) < [data length] && [data length] != LegacyBoxFeedbackLength) {
        *boxFeedback = [[WDBoxFeedbackV3 alloc] init];
        
        const uint8_t *bytes = [data bytes];
        
        int index = ResponseHeaderLength;

        // Loop starts after the response header
        while (index + 1 < [data length]) {
            int groupNo = bytes[index++];
            int groupSize = bytes[index++];

            // Ensure we don't read beyond the buffer's end
            if (index + groupSize > [data length]) {
                return NO;
            }

            switch (groupNo) {
                case 1:
                    // Parse and set battery and drawer states
                    [self parseBatteryAndDrawerState:bytes index:index boxFeedback:*boxFeedback];
                    break;
                case 3:
                    // Parse and set NFC tags
                    [self parseNfcTags:bytes index:index groupSize:groupSize boxFeedback:*boxFeedback];
                    break;
                default:
                    break;
            }

            index += groupSize;
        }
        return YES;
    }
    
    return NO;
}

+ (void)parseBatteryAndDrawerState:(const uint8_t *)bytes index:(int)index boxFeedback:(WDBoxFeedbackV3 *)boxFeedback {
    boxFeedback.batteryStateOfCharge = bytes[index] & 0x7F;
    boxFeedback.batteryIsCharging = (bytes[index] & (1 << 7)) != 0;
    boxFeedback.batteryChargerIsConnected = (bytes[index + 1] & (1 << 7)) != 0;
    boxFeedback.drawerState = (bytes[index + 2] & (1 << 7)) != 0;
    boxFeedback.drawerAccessibility = (bytes[index + 2] & (1 << 6)) != 0;
}

+ (void)parseNfcTags:(const uint8_t *)bytes index:(int)index groupSize:(int)groupSize boxFeedback:(WDBoxFeedbackV3 *)boxFeedback {
    int nfcTagNumber = 1;
    int endIndex = index + groupSize;

    while (index < endIndex && nfcTagNumber <= 3) {
        int uidLength = bytes[index] & 0x0F;
        if (uidLength > 0) {
            NSString *nfcTagUid = [self bytesToHex:bytes offset:index + 1 length:uidLength];
            switch (nfcTagNumber) {
                case 1:
                    boxFeedback.nfcTag1Uid = nfcTagUid;
                    break;
                case 2:
                    boxFeedback.nfcTag2Uid = nfcTagUid;
                    break;
                case 3:
                    boxFeedback.nfcTag3Uid = nfcTagUid;
                    break;
                default:
                    break;
            }
            nfcTagNumber++;
        }
        index += uidLength + 1;
    }
}

+ (NSString *)bytesToHex:(const uint8_t *)bytes offset:(int)offset length:(int)length {
    NSMutableString *hexString = [NSMutableString string];
    for (int i = offset; i < offset + length; i++) {
        [hexString appendFormat:@"%02X", bytes[i]];
    }
    return [hexString copy];
}

@end
