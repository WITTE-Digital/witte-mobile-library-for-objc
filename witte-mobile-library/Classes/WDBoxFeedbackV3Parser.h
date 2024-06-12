//
// WDBoxFeedbackV3Parser.h
// witte-mobile-library
//

#import <Foundation/Foundation.h>
#import <WDBoxFeedbackV3.h>

/**
 * @brief Class for parsing the box feedback data for version 3.
 */
@interface WDBoxFeedbackV3Parser : NSObject

/**
 * @brief Parses the feedback data and populates the WDBoxFeedbackV3 object.
 * @param data The byte array of data to be parsed.
 * @param boxFeedback Pointer to a WDBoxFeedbackV3 object where parsed data will be stored.
 * @return Returns YES on successful parsing, NO otherwise.
 */
+ (BOOL)parseData:(NSData *)data boxFeedback:(WDBoxFeedbackV3 **)boxFeedback;

@end
