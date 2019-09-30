//
//  MouseController.m
//  testMouseCursor
//
//  Created by James Tang on 30/9/2019.
//  Copyright © 2019 James Tang. All rights reserved.
//

#import "MouseController.h"
@import AppKit;

@implementation MouseController

- (void)changeCursor:(Cursor)cursor {
    NSLog(@"XXX changeCursor %@", cursor);

    if ([cursor isEqualToString:CursorText]) {
        [NSCursor.IBeamCursor set];
        NSLog(@"XXX IBeamCursor");
    } else if ([cursor isEqualToString:CursorArrow]) {
        [NSCursor.arrowCursor set];
        NSLog(@"XXX arrowCursor");
    } else {
        NSLog(@"XXX default");
    }
//
//    switch (cursor) {
//        case CursorText:
//            NSLog(@"XXX CursorText");
//            [NSCursor.IBeamCursor set];
//            break;
//        case CursorArrow:
//            NSLog(@"XXX CursorArrow");
//            [NSCursor.arrowCursor set];
//            break;
//        default:
//            NSLog(@"XXX default");
//            break;
//    }
}

@end
