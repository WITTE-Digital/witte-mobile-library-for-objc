//
//  WDBoxFeedbackTests.m
//  wittemobilelibrary_Tests
//

#import <Foundation/Foundation.h>
#import "WDBoxFeedback.h"
#import "WDByteUtils.h"

NSString* const BoxFeedbackLocked01 = @"4C420FFA5008003700D8";
NSString* const BoxFeedbackLocked02 = @"4F420FFA5308003700D9";
NSString* const BoxFeedbackLocked03 = @"4C420FFA4E08003800D9";
NSString* const BoxFeedbackLocked04 = @"4D420FFA4E08003700D8";
NSString* const BoxFeedbackLocked05 = @"4A420FFA4C08003600D8";

NSString* const BoxFeedbackUnlocked01 = @"4FC10FF0590000362AD9";
NSString* const BoxFeedbackUnlocked02 = @"52C20FF0550000352BDA";
NSString* const BoxFeedbackUnlocked03 = @"4FC20FF05500003529D9";
NSString* const BoxFeedbackUnlocked04 = @"4FC30FF0570000362AD9";
NSString* const BoxFeedbackUnlocked05 = @"4CC30FF05700003628D9";

NSString* const BoxFeedbackDrawerOpen01 = @"0DC10FFF0019030000B0";
NSString* const BoxFeedbackDrawerOpen02 = @"0DC30FFF0019030000B0";
NSString* const BoxFeedbackDrawerOpen03 = @"0DC20FFF0019030000AF";
NSString* const BoxFeedbackDrawerOpen04 = @"0DC30FFF0019030000AF";
NSString* const BoxFeedbackDrawerOpen05 = @"0DC20FFF0019030000B0";


SpecBegin(BoxFeedback)

describe(@"Box feedback indicating locked state", ^{
    it(@"box is closed", ^{
        NSArray* array = [[NSArray alloc]initWithObjects:
                          BoxFeedbackLocked01,
                          BoxFeedbackLocked02,
                          BoxFeedbackLocked03,
                          BoxFeedbackLocked04,
                          BoxFeedbackLocked05,
                          nil];
        
        for(id str in array) {
            NSData* data = [WDByteUtils toByteArray:str];
            WDBoxFeedback* boxFeedback = [[WDBoxFeedback alloc]initWithResponseData:data];
            expect(boxFeedback.boxState).to.equal(WDBoxStateLocked);
        }
    });
});

describe(@"Box feedback indicating unlocked state", ^{
    it(@"box is opened", ^{
        NSArray* array = [[NSArray alloc]initWithObjects:
                          BoxFeedbackUnlocked01,
                          BoxFeedbackUnlocked02,
                          BoxFeedbackUnlocked03,
                          BoxFeedbackUnlocked04,
                          BoxFeedbackUnlocked05,
                          nil];
        
        for(id str in array) {
            NSData* data = [WDByteUtils toByteArray:str];
            WDBoxFeedback* boxFeedback = [[WDBoxFeedback alloc]initWithResponseData:data];
            expect(boxFeedback.boxState).to.equal(WDBoxStateUnlocked);
        }
    });
});

describe(@"Box feedback indicating open drawer", ^{
    it(@"box drawer is open", ^{
        NSArray* array = [[NSArray alloc]initWithObjects:
                          BoxFeedbackDrawerOpen01,
                          BoxFeedbackDrawerOpen02,
                          BoxFeedbackDrawerOpen03,
                          BoxFeedbackDrawerOpen04,
                          BoxFeedbackDrawerOpen05,
                          nil];
        
        for(id str in array) {
            NSData* data = [WDByteUtils toByteArray:str];
            WDBoxFeedback* boxFeedback = [[WDBoxFeedback alloc]initWithResponseData:data];
            expect(boxFeedback.boxState).to.equal(WDBoxStateDrawerOpen);
        }
    });
});

describe(@"Calculate battery state of charge from box feedback", ^{
    it(@"battery stage of charge", ^{
        
    });
});

SpecEnd
