//
// WDBoxFeedbackV3.h
// witte-mobile-library
//

#import <Foundation/Foundation.h>

/**
 * @brief Represents the box feedback data for version 3.
 */
@interface WDBoxFeedbackV3 : NSObject

/**
 * Initializes a new instance of WDBoxFeedbackV3.
 */
- (instancetype)init;

/**
 * @brief Represents the battery's state of charge as a percentage (0-100).
 */
@property (nonatomic, assign) uint8_t batteryStateOfCharge;

/**
 * @brief True if the battery is currently charging.
 */
@property (nonatomic, assign) BOOL batteryIsCharging;

/**
 * @brief True if the charger is connected.
 */
@property (nonatomic, assign) BOOL batteryChargerIsConnected;

/**
 * @brief True if the drawer is opened, false if the drawer is closed.
 */
@property (nonatomic, assign) BOOL drawerState;

/**
 * @brief True if the drawer is unlocked, false if the drawer is locked.
 */
@property (nonatomic, assign) BOOL drawerAccessibility;

@end
