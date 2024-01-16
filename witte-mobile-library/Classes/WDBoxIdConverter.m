//
// WDBoxIdConverter.m
// witte-mobile-library
//

#import "WDBoxIdConverter.h"
#import "WDByteUtils.h"

@implementation WDBoxIdConverter

- (NSString*)toPhysicalLockIdWithBoxId:(NSString*)boxId {
    NSString* physicalLockId = nil;
    
    if(boxId) {
        
        // remove separators
        NSString* hexString = [boxId stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        NSData* boxIdBytes = [WDByteUtils toByteArray:hexString];
        
        // create prefix
        NSMutableData* prefixBytes = [NSMutableData dataWithCapacity:2];
        
        unsigned char len = boxIdBytes.length;
        [prefixBytes replaceBytesInRange:NSMakeRange(0, 1) withBytes:&len];
        
        char zero = 0x00;
        [prefixBytes replaceBytesInRange:NSMakeRange(1, 1) withBytes:&zero];
        
        // concat prefix and payload
        NSMutableData* bytes = [[NSMutableData alloc]init];
        [bytes appendData:prefixBytes];
        [bytes appendData:boxIdBytes];
        
        // convert to base64
        physicalLockId = [bytes base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    }
    
    return physicalLockId;
}

- (NSString*)toBoxIdWithPhysicalLockId:(NSString*)physicalLockId {
    NSString* boxId = nil;
    
    if(physicalLockId) {
        
        // decode base64 string
        NSData* bytes = [[NSData alloc]initWithBase64EncodedString:physicalLockId options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        // extract box id bytes
        NSData* boxIdBytes = [bytes subdataWithRange:NSMakeRange(2, 4)];
        
        // convert to hex representation
        NSString* hexString = [self toHexWithData:boxIdBytes];
        NSMutableString* muHexString = [NSMutableString stringWithString:hexString];
        
        // add separators
        [muHexString insertString:@"-" atIndex:2];
        [muHexString insertString:@"-" atIndex:5];
        [muHexString insertString:@"-" atIndex:8];
        
        boxId = [NSString stringWithString:muHexString];
    }
    
    return boxId;
}

- (NSString*)toHexWithData:(NSData*)data
{
    const char* hexTable = "0123456789ABCDEF";
    const NSUInteger byteLength = data.length;
    const NSUInteger charLength = byteLength * 2;
    char *const hexChars = malloc(charLength * sizeof(*hexChars));
    
    __block char *charPtr = hexChars;
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        const uint8_t *bytePtr = bytes;
        for (NSUInteger count = 0; count < byteRange.length; ++count) {
            const uint8_t byte = *bytePtr++;
            *charPtr++ = hexTable[(byte >> 4) & 0xF];
            *charPtr++ = hexTable[byte & 0xF];
        }
    }];
    
    return [[NSString alloc] initWithBytesNoCopy:hexChars length:charLength encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

- (Boolean)isValidBoxIdWithBoxId:(NSString*)boxId
{
    Boolean isValidBoxId = false;
    
    if(0 < [boxId length])
    {
        NSString* pattern = @"[A-Z0-9]{2}(-[A-Z0-9]{2}){3}";
        NSRange searchedRange = NSMakeRange(0, [boxId length]);
        NSError* error = nil;
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: pattern options:0 error:&error];
        NSArray* matches = [regex matchesInString:boxId options:0 range: searchedRange];
        if(1 == [matches count])
        {
            isValidBoxId = true;
        }
    }
    
    return isValidBoxId;
}

@end
