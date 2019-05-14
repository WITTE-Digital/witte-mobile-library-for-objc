//
//  WDIdTokenRequest.m
//  witte-mobile-library
//

#import "WDIdTokenRequest.h"

NSString* const WD_URL_GET_OAUTH_TOKEN = @"https://wittedigitalapimprod.azure-api.net/v1/app/sdk/GetOAuthToken";

@implementation WDIdTokenRequest

- (NSString*) executeWithConfiguration:(WDConfiguration*)configuration andUserId:(NSInteger)userId {
    NSString* idToken = nil;
    
    if(configuration) {
        
        NSDictionary* dict = [[NSDictionary alloc]initWithObjectsAndKeys:
                              [NSNumber numberWithInteger:configuration.witteCustomerId] , @"CustomerId",
                              [NSNumber numberWithInteger:userId], @"UserId",
                              configuration.witteSdkKey, @"SdkKey",
                              nil];
        NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString* postBody = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSString* postBodyLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postBody length]];
        
        NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:WD_URL_GET_OAUTH_TOKEN]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:postBodyLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:configuration.witteSubscriptionKey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
        [request setHTTPBody:[postBody dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLResponse* response = nil;
        NSError* error = nil;
        NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if(!error) {
            NSLog(@"%@", [NSString stringWithUTF8String:[responseData bytes]]);
            
            // evaluate response
            NSMutableDictionary* respDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
            
            NSString* payload = respDict[@"Data"];
            if(payload) {
                idToken = [payload stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            }
        }
        else {
            NSLog(@"Failed to retrieve id token: %@", [error description]);
            
            // evaluate response
            NSMutableDictionary* respDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
            NSLog(@"Status Code = %@", respDict[@"statusCode"]);
            NSLog(@"Message = %@", respDict[@"message"]);
        }
    }
    
    return idToken;
}

@end
