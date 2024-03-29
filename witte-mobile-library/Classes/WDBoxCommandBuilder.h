//
// WDBoxCommandBuilder.h
// witte-mobile-library
//

#import <Foundation/Foundation.h>

/// This class is responsible for creating commands for the flinkey BLE box.
@interface WDBoxCommandBuilder : NSObject

/// Builds a command to unlock the car and unlock the box.
/// @return A byte array representing the command.
+ (NSData *)buildUnlockCarUnlockBox;

/// Builds a command to unlock the car and lock the box.
/// @return A byte array representing the command.
+ (NSData *)buildUnlockCarLockBox;

/// Builds a command to lock the car and lock the box.
/// @return A byte array representing the command.
+ (NSData *)buildLockCarLockBox;

/// Builds a command to get the status.
/// @return A byte array representing the command.
+ (NSData *)buildStatus;

@end
