//
//  UIImage+Draw.swift
//  testMouseCursor
//
//  Created by James Tang on 4/6/2020.
//  Copyright © 2020 James Tang. All rights reserved.
//

import UIKit

enum ImageError: Error {
    case failedToGetContext
    case failedToGetImage
}

extension UIImage {

    typealias ContextDrawHandler = ((CGContext, CGSize, CGFloat) -> Void)

    static func draw(size: CGSize, handler: @escaping ContextDrawHandler) throws -> UIImage? {
        let scale: CGFloat = UIScreen.main.scale
        //        UIGraphicsBeginImageContextWithOptions(size.applying(.init(scaleX: scale, y: scale)), false, 1)

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else {
            throw ImageError.failedToGetContext
        }

        handler(context, size, scale)

        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else {
            throw ImageError.failedToGetImage
        }
        return newImage
    }
}
