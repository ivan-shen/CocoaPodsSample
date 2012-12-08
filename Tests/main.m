//
//  main.m
//  Tests
//
//  Created by mtgto on 12/8/12.
//  Copyright (c) 2012 mtgto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GHUnitIOS/GHUnit.h>

// Hack for over iOS SDK 6.0 (Thanks gfx!).
// @see https://github.com/gabriel/gh-unit/issues/96#issuecomment-10885113
@interface MyUIApp : UIApplication
@end

@implementation MyUIApp

- (id)init
{
    self = [super init];
    if (self && getenv("GHUNIT_CLI") && [[[UIDevice currentDevice] systemVersion] doubleValue] >= 6.0) {
        __block BOOL done = NO;
        NSOperationQueue * queue = [[ NSOperationQueue alloc ] init ];
        [queue addOperationWithBlock:^{
            int status = [GHTestRunner run];
            if (status != 0) {
                NSString *reason = [NSString stringWithFormat:@"failed to test %d", status];
                @throw [NSException exceptionWithName:@"TestFailure" reason:reason userInfo:nil];
            }
            done = YES;
        }];

        while( !done ) {
            [[NSRunLoop currentRunLoop] runUntilDate: [NSDate dateWithTimeIntervalSinceNow: 5] ];
        }
    }

    return self;
}

@end

int main(int argc, char *argv[])
{
    @autoreleasepool {
        return UIApplicationMain(argc, argv, @"MyUIApp", @"GHUnitIOSAppDelegate");
    }
}