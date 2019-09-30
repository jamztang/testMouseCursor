//
//  MouseController.h
//  testMouseCursor
//
//  Created by James Tang on 30/9/2019.
//  Copyright © 2019 James Tang. All rights reserved.
//

#ifndef MouseController_h
#define MouseController_h

#import "MouseControllerProtocol.h"

/// This class can be loaded using the following code
/// not using Swift because somehow it would not work when inferring it's type if we do
/// `let instance = principleClass.init() as! MouseControllerProtocol`
///
//static func fromMouseControllerBundle<T>(bundle: String) -> T {
//    guard let path = Bundle.main.path(forResource: "MouseController", ofType: "bundle") else {
//        fatalError("XXX bundle not found")
//    }
//    guard let bundle = Bundle(path: path) else {
//        fatalError("XXX bundle not found \(path)")
//    }
//
//    do {
//        try bundle.loadAndReturnError()
//    } catch {
//        fatalError("XXX bundle loading failed. \(error)")
//    }
//
//    guard let principleClass = bundle.principalClass as? NSObject.Type else {
//        fatalError("XXX principleClass noClass")
//    }
//
//    let instance = principleClass.init() as! T
//    return instance
//}

@import Foundation;

@interface MouseController: NSObject <MouseControllerProtocol>

@end

#endif /* MouseController_h */
