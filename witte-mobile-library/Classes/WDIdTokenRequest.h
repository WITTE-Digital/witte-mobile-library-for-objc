//
//  WDIdTokenRequest.h
//  witte-mobile-library
//

#import <Foundation/Foundation.h>
#import "WDConfiguration.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString* const WD_URL_GET_OAUTH_TOKEN;

@interface WDIdTokenRequest : NSObject

- (NSString*) executeWithConfiguration:(WDConfiguration*)configuration andUserId:(NSInteger)userId;

@end

NS_ASSUME_NONNULL_END
