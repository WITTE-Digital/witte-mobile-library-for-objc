//
// WDBoxCommandConfig.h
// witte-mobile-library
//

#import <Foundation/Foundation.h>

/// This class is used to configure the commands that are built by the WDBoxCommandBuilder.
@interface WDBoxCommandConfig : NSObject

/// Indicates whether a factory reset command should be built.
@property (nonatomic, assign) BOOL factoryReset;

/// Indicates whether a status command should be built.
@property (nonatomic, assign) BOOL status;

/// Indicates whether a command to unlock the car should be built.
@property (nonatomic, assign) BOOL unlockCar;

/// Indicates whether a command to lock the car should be built.
@property (nonatomic, assign) BOOL lockCar;

/// Indicates whether a command to unlock the box should be built.
@property (nonatomic, assign) BOOL unlockBox;

/// Indicates whether a command to lock the box should be built.
@property (nonatomic, assign) BOOL lockBox;

@end
