//
//  MouseController.swift
//  MouseController
//
//  Created by James Tang on 29/9/2019.
//  Copyright © 2019 James Tang. All rights reserved.
//

import AppKit

public class MouseController: NSObject, MouseProtocol {

    var notificationHandler: Any!

    override required public init() {
        super.init()
        let notificationHandler = NotificationCenter.default.addObserver(forName: NSNotification.Name("ChangeCursorNotification"), object: nil, queue: OperationQueue.main, using: { [weak self] (notification) in
            self?.handleCursorNotification(notification: notification)
        })
        self.notificationHandler = notificationHandler
    }

    func handleCursorNotification(notification: Notification) {
        Swift.print("handleCursorNotification \(notification)")
    }

    public func changeCursor(_ cursor: Cursor) {
        switch cursor {
        case .text:
            NSCursor.iBeam.set()
        case .arrow:
            NSCursor.arrow.set()
        }
    }

}
