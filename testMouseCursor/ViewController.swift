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

        let crosshairStrokeLength: CGFloat = 9
        var size = CGSize(width: length, height: length).applying(.init(scaleX: mouseTransform, y: mouseTransform))

        // Adding spaces for crosshair
        size.width += crosshairStrokeLength * 2
        size.height += crosshairStrokeLength * 2

        let image = try? UIImage.draw(size: size, scale: accessibilityMouseTransform) { (context, size, scale) in

////            context.setFillColor(UIColor.yellow.cgColor)
////            context.addRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
//            context.drawPath(using: CGPathDrawingMode.fill)
////            context.stroke(CGRect(x: 0, y: 0, width: size.width, height: size.height), width: 1)
//
//            context.setFillColor(UIColor.black.cgColor)
//            context.addRect(CGRect(x: size.width / 2 - 1, y: 2, width: 1, height: 3))
//            context.setStrokeColor(UIColor.white.cgColor)
//            context.addPath(CGPath(roundedRect: CGRect(x: size.width / 2 - 1.5, y: 1, width: 3, height: 5), cornerWidth: 1, cornerHeight: 1, transform: nil))
//            context.strokePath()
//
//            let strokeWidth: CGFloat = size.width - (2 * crosshairStrokeLength)
//            let color: UIColor = .green
//            let rectangle = CGRect(x: crosshairStrokeLength,
//                                   y: crosshairStrokeLength,
//                                   width: strokeWidth,
//                                   height: strokeWidth)
//
//            Swift.print("XXX mouse.changeCursor(.image) size \(size) \(scale) \(rectangle)")
//            context.setFillColor(color.cgColor)
//            context.setShouldAntialias(true)
//            context.setAllowsAntialiasing(true)
//            context.addEllipse(in: rectangle)
//            context.drawPath(using: CGPathDrawingMode.fill)

            let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

            func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }

            //// Color Declarations
            let color = UIColor(red: 0.863, green: 0.863, blue: 0.863, alpha: 1.000)
            let color2 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

            //// Shadow Declarations
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
            shadow.shadowOffset = CGSize(width: 0, height: 1)
            shadow.shadowBlurRadius = 2

//            //// Rectangle 3 Drawing
//            let rectangle3Path = UIBezierPath(rect: CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: frame.height))
//            color.setFill()
//            rectangle3Path.fill()
//

            //// Circle Drawing
            let circlePath = UIBezierPath(ovalIn: CGRect(x: frame.minX + 9, y: frame.minY + 9, width: frame.width - 18, height: frame.height - 18))
            UIColor.gray.setFill()
            circlePath.fill()
            UIColor.white.setStroke()
            circlePath.lineWidth = 1
            circlePath.stroke()


            //// T Drawing
            let tPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor((frame.width - 2) * 0.50000 + 0.5), y: frame.minY + 2, width: 2, height: 5), cornerRadius: 0.5)
            context.saveGState()
            context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color2.setFill()
            tPath.fill()
            context.restoreGState()

            UIColor.white.setStroke()
            tPath.lineWidth = 1
            tPath.stroke()


            //// B Drawing
            let bPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor((frame.width - 2) * 0.50000 + 0.5), y: frame.minY + frame.height - 7, width: 2, height: 5), cornerRadius: 0.5)
            context.saveGState()
            context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color2.setFill()
            bPath.fill()
            context.restoreGState()

            UIColor.white.setStroke()
            bPath.lineWidth = 1
            bPath.stroke()


            //// R Drawing
            let rPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + frame.width - 7, y: frame.minY + fastFloor((frame.height - 2) * 0.50000 + 0.5), width: 5, height: 2), cornerRadius: 0.5)
            context.saveGState()
            context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color2.setFill()
            rPath.fill()
            context.restoreGState()

            UIColor.white.setStroke()
            rPath.lineWidth = 1
            rPath.stroke()


            //// L Drawing
            let lPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + 2, y: frame.minY + fastFloor((frame.height - 2) * 0.50000 + 0.5), width: 5, height: 2), cornerRadius: 0.5)
            context.saveGState()
            context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color2.setFill()
            lPath.fill()
            context.restoreGState()

            UIColor.white.setStroke()
            lPath.lineWidth = 1
            lPath.stroke()
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

