//
//  MouseProtocol.swift
//  MouseController
//
//  Created by James Tang on 29/9/2019.
//  Copyright © 2019 James Tang. All rights reserved.
//

import Foundation

public enum Cursor {
    case text
    case arrow
}

public protocol MouseProtocol: class {
    init()
    func changeCursor(_ cursor: Cursor)
}
