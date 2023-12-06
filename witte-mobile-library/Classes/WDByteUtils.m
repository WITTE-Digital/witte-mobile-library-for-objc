//
// WDByteUtils.m
// witte-mobile-library
//

#import "WDByteUtils.h"

@implementation WDByteUtils

static const uint8_t invalidNibble = 128;

static uint8_t nibbleFromChar(unichar c) {
    if (c >= '0' && c <= '9') {
        return c - '0';
    }
    else if (c >= 'A' && c <= 'F') {
        return 10 + c - 'A';
    }
    else if (c >= 'a' && c <= 'f') {
        return 10 + c - 'a';
    }
    else {
        return invalidNibble;
    }
}

+ (NSData*)toByteArray:(NSString*)hexString {
    
    if (!hexString) {
        return nil;
    }
    
    const NSUInteger charLength = hexString.length;
    const NSUInteger maxByteLength = charLength / 2;
    uint8_t *const bytes = malloc(maxByteLength);
    uint8_t *bytePtr = bytes;
    
    CFStringInlineBuffer inlineBuffer;
    CFStringInitInlineBuffer((CFStringRef)hexString, &inlineBuffer, CFRangeMake(0, charLength));
    
    // Each byte is made up of two hex characters; store the outstanding half-byte until we read the second
    uint8_t hiNibble = invalidNibble;
    for (CFIndex i = 0; i < charLength; ++i) {
        uint8_t nextNibble = nibbleFromChar(CFStringGetCharacterFromInlineBuffer(&inlineBuffer, i));
        
        if (nextNibble == invalidNibble) {
            free(bytes);
            return nil;
        }
        else if (hiNibble == invalidNibble) {
            hiNibble = nextNibble;
        }
        else if (nextNibble != invalidNibble) {
            // Have next full byte
            *bytePtr++ = (hiNibble << 4) | nextNibble;
            hiNibble = invalidNibble;
        }
    }
    
    if (hiNibble != invalidNibble) { // trailing hex character
        free(bytes);
        return nil;
    }
    
    return [[NSData alloc] initWithBytesNoCopy:bytes length:(bytePtr - bytes) freeWhenDone:YES];
}

+ (BOOL) isBitSetWithByteValue:(char)byteValue
                      bitIndex:(NSUInteger)bitIndex {
    BOOL result = NO;
    
    if(0 <= bitIndex && bitIndex <= 7) {
        result = 0 != (byteValue & (1 << bitIndex));
    }
    
    return result;
}

@end
