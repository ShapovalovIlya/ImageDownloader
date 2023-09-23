//
//  CGImage.swift
//
//
//  Created by Илья Шаповалов on 22.09.2023.
//

import CoreGraphics
import Foundation
import Cocoa

extension CGImage {
    var size: CGSize {
        .init(
            width: self.width.cgFloat,
            height: self.height.cgFloat
        )
    }
    
    var context: CGContext? {
        .init(
            data: nil,
            width: self.width,
            height: self.height,
            bitsPerComponent: self.bitsPerComponent,
            bytesPerRow: self.bytesPerRow,
            space: self.colorSpace ?? CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: self.bitmapInfo.rawValue
        )
    }
    
    static func create(from imageData: Data) throws -> CGImage {
        guard
            let imageSource = CGImageSourceCreateWithData(imageData as CFData, nil),
            let image = CGImageSourceCreateImageAtIndex(imageSource, 0, nil)
        else {
            throw URLError(.cannotDecodeContentData)
        }
        return image
    }
}
