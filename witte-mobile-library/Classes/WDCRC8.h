//
// WDCRC8.h
// witte-mobile-library
//

#import <Foundation/Foundation.h>

/// This class provides a method for computing a CRC-8 checksum.
/// The checksum is used for ensuring the integrity of command bytes in WDBoxCommandBuilder.
@interface WDCRC8 : NSObject

/// Computes a CRC8 checksum for the given byte array.
/// @param data The byte array for which to compute the checksum.
/// @return The computed CRC8 checksum.
+ (uint8_t)computeChecksum:(NSData *)data;

@end
