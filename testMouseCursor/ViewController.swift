//
//  ViewController.swift
//  testMouseCursor
//
//  Created by James Tang on 29/9/2019.
//  Copyright © 2019 James Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func cursorButtonDidPress(_ sender: Any) {
        Swift.print("cursorButtonDidPress")
    }

    @IBAction func textButtonDidPress(_ sender: Any) {
        Swift.print("textButtonDidPress")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

