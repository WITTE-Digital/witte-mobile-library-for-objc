//
// WDBoxIdConverter.h
// witte-mobile-library
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Converts a physical lock id to a flinkey box id and vice versa.
 */
@interface WDBoxIdConverter : NSObject

/**
 * Convert a WITTE/flinkey Box ID (e.g 'C1-08-F0-94') to a physical lock ID (e.g. 'BADBCPCU')
 * that can be provided to the Tapkey Mobile SDK.
 */
- (NSString*)toPhysicalLockIdWithBoxId:(NSString*)boxId;

/**
 * Convert a physical lock ID to a WITTE/flinkey Box ID.
 */
- (NSString*)toBoxIdWithPhysicalLockId:(NSString*)physicalLockId;

/**
 * Check if a string is a valid flinkey Box ID.
 */
- (Boolean)isValidBoxIdWithBoxId:(NSString*)boxId;

@end

NS_ASSUME_NONNULL_END
