//
//  WDBoxIdConverterTests.m
//  witte-mobile-library_Tests
//

#import <Foundation/Foundation.h>
#import "WDBoxIdConverter.h"
#import "WDByteUtils.h"

NSString* const BoxId = @"C1-08-F0-94";
NSString* const PhysicalLockId = @"BADBCPCU";

SpecBegin(BoxIdConverter)

describe(@"Convert box id to physical lock id", ^{
    
    it(@"success", ^{
        
        WDBoxIdConverter* converter = [[WDBoxIdConverter alloc]init];
        NSString* physicalLockId = [converter toPhysicalLockIdWithBoxId:BoxId];
        expect(physicalLockId).to.equal(PhysicalLockId);
    });
});

describe(@"Convert physical lock id box id", ^{
    
    it(@"success", ^{
        
        WDBoxIdConverter* converter = [[WDBoxIdConverter alloc]init];
        NSString* boxId = [converter toBoxIdWithPhysicalLockId:PhysicalLockId];
        expect(boxId).to.equal(BoxId);
    });
});

SpecEnd
