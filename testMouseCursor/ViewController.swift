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

        let circlePadding: CGFloat = 9 / catalystTransform
        var size = CGSize(width: length, height: length).applying(.init(scaleX: mouseTransform, y: mouseTransform))

        // Adding spaces for crosshair
        size.width += circlePadding * 2
        size.height += circlePadding * 2

        let crosshairStrokeLength: CGFloat = 4 / catalystTransform
        let crosshairStrokeWidth: CGFloat = 2 / catalystTransform
        let crosshairStrokePadding: CGFloat = 3 / catalystTransform

        let showCrosshair = length * catalystTransform < 7

        let image = try? UIImage.draw(size: size, scale: accessibilityMouseTransform) { (context, size, scale) in

            let frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

            func fastFloor(_ x: CGFloat) -> CGFloat { return floor(x) }

            //// Color Declarations
            let color2 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

            //// Shadow Declarations
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.black.withAlphaComponent(0.3)
            shadow.shadowOffset = CGSize(width: 0, height: 1)
            shadow.shadowBlurRadius = 2

            //// Circle Drawing
            let circlePath = UIBezierPath(ovalIn: CGRect(x: frame.minX + circlePadding, y: frame.minY + circlePadding, width: frame.width - circlePadding * 2, height: frame.height - circlePadding * 2))
            UIColor.gray.setFill()
            circlePath.fill()
            UIColor.white.setStroke()
            circlePath.lineWidth = 1 / scale
            circlePath.stroke()


            guard showCrosshair else { return }

            //// T Drawing
            let tPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor((frame.width - crosshairStrokeWidth) * 0.50000 + 0.5), y: frame.minY + crosshairStrokePadding, width: crosshairStrokeWidth, height: crosshairStrokeLength), cornerRadius: 0.5)
            context.saveGState()
            context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color2.setFill()
            tPath.fill()
            context.restoreGState()

            UIColor.white.setStroke()
            tPath.lineWidth = 1 / catalystTransform
            tPath.stroke()


            //// B Drawing
            let bPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + fastFloor((frame.width - crosshairStrokeWidth) * 0.50000 + 0.5), y: frame.minY + frame.height - (crosshairStrokePadding + crosshairStrokeLength), width: crosshairStrokeWidth, height: crosshairStrokeLength), cornerRadius: 0.5)
            context.saveGState()
            context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color2.setFill()
            bPath.fill()
            context.restoreGState()

            UIColor.white.setStroke()
            bPath.lineWidth = 1 / catalystTransform
            bPath.stroke()


            //// R Drawing
            let rPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + frame.width - (crosshairStrokePadding + crosshairStrokeLength), y: frame.minY + fastFloor((frame.height - crosshairStrokeWidth) * 0.50000 + 0.5), width: crosshairStrokeLength, height: crosshairStrokeWidth), cornerRadius: 0.5)
            context.saveGState()
            context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color2.setFill()
            rPath.fill()
            context.restoreGState()

            UIColor.white.setStroke()
            rPath.lineWidth = 1 / catalystTransform
            rPath.stroke()


            //// L Drawing
            let lPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + crosshairStrokePadding, y: frame.minY + fastFloor((frame.height - crosshairStrokeWidth) * 0.50000 + 0.5), width: crosshairStrokeLength, height: crosshairStrokeWidth), cornerRadius: 0.5)
            context.saveGState()
            context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
            color2.setFill()
            lPath.fill()
            context.restoreGState()

            UIColor.white.setStroke()
            lPath.lineWidth = 1 / catalystTransform
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

