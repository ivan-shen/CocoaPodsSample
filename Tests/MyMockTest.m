//
//  MyMockTest.m
//  CocoaPodsSample
//
//  Created by User on 12/9/12.
//  Copyright (c) 2012 mtgto. All rights reserved.
//

#import "MyMockTest.h"

@implementation MyMockTest

- (void)testMock {
    id mock = [OCMockObject mockForClass:[NSString class]];
    [[[mock stub] andReturnValue:OCMOCK_VALUE((NSUInteger){100})] length];

    GHAssertEquals(100U, [mock length], @"ocmock works");
}

@end
