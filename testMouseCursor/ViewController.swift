//
//  ViewController.swift
//  testMouseCursor
//
//  Created by James Tang on 29/9/2019.
//  Copyright © 2019 James Tang. All rights reserved.
//

import UIKit

class Proxy<T>: NSObject {
    let target: T

    init(_ target: T) {
        self.target = target
    }

    static func fromBundle(bundle: String) -> Proxy<T> {
        guard let path = Bundle.main.path(forResource: bundle, ofType: "bundle") else {
            fatalError("XXX bundle not found")
        }
        guard let bundle = Bundle(path: path) else {
            fatalError("XXX bundle not found \(path)")
        }

        do {
            try bundle.loadAndReturnError()
        } catch {
            fatalError("XXX bundle loading failed. \(error)")
        }

        guard let principleClass = bundle.principalClass as? NSObject.Type else {
            fatalError("XXX principleClass noClass")
        }

        let instance = principleClass.init() as! T
        return Proxy(instance)
    }
}

class ViewController: UIViewController {
    private let mouse = Proxy<MouseControllerProtocol>.fromBundle(bundle: "MouseController").target

    @IBAction func cursorButtonDidPress(_ sender: Any) {
        Swift.print("XXX mouse.changeCursor(.arrow)")
        mouse.changeCursor(CursorArrow)
    }

    @IBAction func textButtonDidPress(_ sender: Any) {
        Swift.print("XXX mouse.changeCursor(.text)")
        mouse.changeCursor(CursorText)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

