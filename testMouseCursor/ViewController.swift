//
//  ViewController.swift
//  testMouseCursor
//
//  Created by James Tang on 29/9/2019.
//  Copyright © 2019 James Tang. All rights reserved.
//

import UIKit

func fromBundle<T>(_ bundleName: String) -> T {
    guard let path = Bundle.main.path(forResource: bundleName, ofType: "bundle") else {
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
    return instance
}

class ViewController: UIViewController {
    private let mouse: MouseControllerProtocol = fromBundle("MouseController")
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var sizeSlider: UISlider!
    @IBOutlet weak var sizePreview: UIView!
    private var length: CGFloat = 30 {
        didSet {
            let rect = CGRect(origin: sizeTextField.frame.origin, size: CGSize(width: length, height: length))
            sizePreview.frame = rect
            sizePreview.center = view.center
            sizeTextField.text = "\(length)"
        }
    }

    @IBAction func cursorButtonDidPress(_ sender: Any) {
        Swift.print("XXX mouse.changeCursor(.arrow)")
        mouse.change(.arrow)
    }

    @IBAction func textButtonDidPress(_ sender: Any) {
        Swift.print("XXX mouse.changeCursor(.text)")
        mouse.change(.text)
    }

    @IBAction func customImageDidPress(_ sender: Any) {
        reloadMouse()
    }

    @IBAction func sizeSliderValueDidChange(_ sender: Any) {
        length = CGFloat(sizeSlider.value).rounded()
        reloadMouse()
    }

    private func reloadMouse() {
        // According to https://developer.apple.com/design/human-interface-guidelines/ios/overview/mac-catalyst/
        // we know the catalyst app content is scaled by 77%, so we need to downsize the image
        let catalystTransform: CGFloat = 0.77

        // We know macOS system has a cursor size accessibility settings
        let accessibility = UserDefaults.standard.persistentDomain(forName: "com.apple.universalaccess")
        let accessibilityMouseTransform = accessibility?["mouseDriverCursorSize"] as? CGFloat ?? 1
        let mouseTransform = catalystTransform / accessibilityMouseTransform

        let size = CGSize(width: length, height: length).applying(CGAffineTransform.init(scaleX: mouseTransform, y: mouseTransform))
        let image = try? UIImage.draw(size: size) { (context, size, scale) in
            Swift.print("XXX mouse.changeCursor(.image) size \(size) \(scale)")

            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            context.setFillColor(UIColor.green.cgColor)
            context.fill(rect)
        }
        if let data = image??.pngData() {
            mouse.setCursorImageData(data, hotSpot: CGPoint(x: size.height / 2, y: size.height / 2))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

