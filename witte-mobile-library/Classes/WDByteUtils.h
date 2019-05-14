//
//  WDByteUtils.h
//  witte-mobile-library
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WDByteUtils : NSObject

+ (NSData*)toByteArray:(NSString*)hexString;

+ (BOOL) isBitSetWithByteValue:(char)byteValue
                      bitIndex:(NSUInteger)bitIndex;

@end

NS_ASSUME_NONNULL_END
