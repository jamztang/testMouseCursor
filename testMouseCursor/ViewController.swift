//
//  ViewController.swift
//  testMouseCursor
//
//  Created by James Tang on 29/9/2019.
//  Copyright © 2019 James Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//    private let mouse = Mouse()
    private var mouse: MouseProtocol!

    @IBAction func cursorButtonDidPress(_ sender: Any) {
        Swift.print("cursorButtonDidPress")
        mouse.changeCursor(.arrow)
    
    }

    @IBAction func textButtonDidPress(_ sender: Any) {
        Swift.print("textButtonDidPress")
        mouse.changeCursor(.text)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let mouseController = NSClassFromString("MouseController")
//        print("beforeload mouseController \(mouseController)")
//
        print("XXX allBundle \(Bundle.allBundles)")

        guard let path = Bundle.main.path(forResource: "MouseController", ofType: "bundle") else {
            print("XXX bundle not found")
            return
        }
        print("XXX path \(path)")
        guard let bundle = Bundle(path: path) else {
            return
        }
        do {
            try bundle.loadAndReturnError()
        } catch {
            print("XXX bundle loading failed. \(error)")
            return
        }
        print("XXX bundle \(bundle)")

        guard let principleClass = bundle.principalClass as? NSObject.Type else {
            print("XXX principleClass noClass")
            return
        }

        print("XXX principleClass \(principleClass)")
//        let clz : AnyClass = principleClass

        let instance = principleClass.init()
        print("XXX instance \(instance)")

        guard let pro = instance as? MouseProtocol else {
            print("XXX instancd not mouseProtocol")
            return
        }

        mouse = pro
        print("XXX mouse \(mouse)")

    }


}

