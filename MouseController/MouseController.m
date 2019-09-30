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
    switch (cursor) {
        case CursorText:
            [NSCursor.IBeamCursor set];
            break;
        case CursorArrow:
            [NSCursor.arrowCursor set];
            break;
    }
}

@end
