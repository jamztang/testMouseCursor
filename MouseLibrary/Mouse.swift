//
//  Mouse.swift
//  MouseLibrary
//
//  Created by James Tang on 29/9/2019.
//  Copyright © 2019 James Tang. All rights reserved.
//

import AppKit

public class Mouse: MouseProtocol {

    required public init() {

    }

    public func changeCursor(_ cursor: Cursor) {
        Swift.print("changingCursor to \(cursor)")
//        #if !targetEnvironment(macCatalyst)
//        Swift.print("changingCursor to \(cursor) macCatalyst")
        switch cursor {
        case .text:
            NSCursor.iBeam.set()
        case .arrow:
            NSCursor.arrow.set()
        }
//        #endif
    }
}
