//
//  MouseController.h
//  testMouseCursor
//
//  Created by James Tang on 30/9/2019.
//  Copyright © 2019 James Tang. All rights reserved.
//

@import Foundation;

//typedef NSString * Cursor;
//static Cursor const CursorText = @"text";
//static Cursor const CursorArrow = @"arrow";

typedef NS_ENUM(NSUInteger, Cursor) {
    CursorText,
    CursorArrow,
};

@protocol MouseControllerProtocol

- (void)changeCursor:(Cursor)cursor;
- (void)setCursorImageData:(NSData *)image hotSpot:(CGPoint)point;

@end

