//
// WDBoxCommandBuilder.h
// witte-mobile-library
//

#import <Foundation/Foundation.h>
#import <WDBoxCommandConfig.h>

/// This class is responsible for creating commands for the flinkey BLE box.
@interface WDBoxCommandBuilder : NSObject

/// Builds a command to unlock the car and unlock the box.
/// @return A byte array representing the command.
+ (NSData *)buildUnlockCarUnlockBox;

/// Builds a command to unlock the car and unlock the box with an optional NFC read.
/// @param readNfc If true, the command will include reading NFC.
/// @return A byte array representing the command.
+ (NSData *)buildUnlockCarUnlockBox:(BOOL)readNfc;

/// Builds a command to unlock the car and lock the box.
/// @return A byte array representing the command.
+ (NSData *)buildUnlockCarLockBox;

/// Builds a command to unlock the car and lock the box with an optional NFC read.
/// @param readNfc If true, the command will include reading NFC.
/// @return A byte array representing the command.
+ (NSData *)buildUnlockCarLockBox:(BOOL)readNfc;

/// Builds a command to lock the car and lock the box.
/// @return A byte array representing the command.
+ (NSData *)buildLockCarLockBox;

/// Builds a command to lock the car and lock the box with an optional NFC read.
/// @param readNfc If true, the command will include reading NFC.
/// @return A byte array representing the command.
+ (NSData *)buildLockCarLockBox:(BOOL)readNfc;

/// Builds a command to get the status.
/// @return A byte array representing the command.
+ (NSData *)buildStatus;

/// Builds a command to get the status with an optional NFC read.
/// @param readNfc If true, the command will include reading NFC.
/// @return A byte array representing the command.
+ (NSData *)buildStatus:(BOOL)readNfc;

/// Builds a command to read NFC.
/// @return A byte array representing the command.
+ (NSData *)buildReadNfc;
@end
