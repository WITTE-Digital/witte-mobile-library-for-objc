//
// WDBoxFeedbackV3Parser.m
// witte-mobile-library
//

#import "WDBoxFeedbackV3Parser.h"

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
        
        // Loop starts after the response header
        for (int i = ResponseHeaderLength + 1; i < [data length]; i++) {
            int groupNo = bytes[i - 1];
            int groupSize = bytes[i];
            
            // Ensure we don't read beyond the buffer's end
            if (i + groupSize >= [data length]) {
                return NO;
            }
            
            // Parse specific group data
            if (groupNo == 1) {
                // Parsing and setting properties
                (*boxFeedback).batteryStateOfCharge = bytes[i + 1] & 0x7F;
                (*boxFeedback).batteryIsCharging = (bytes[i + 1] & (1 << 7)) != 0;
                (*boxFeedback).batteryChargerIsConnected = (bytes[i + 2] & (1 << 7)) != 0;
                (*boxFeedback).drawerState = (bytes[i + 3] & (1 << 7)) != 0;
                (*boxFeedback).drawerAccessibility = (bytes[i + 3] & (1 << 6)) != 0;
                
                return YES;
            } else {
                // Skip non-relevant groups
                i += (1 + groupSize);
            }
        }
    }
    
    return NO;
}

@end
