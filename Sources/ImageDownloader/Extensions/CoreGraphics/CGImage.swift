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
    
    func contextBody(_ completion: (CGContext) -> Void) throws -> CGImage {
        guard 
            let dataProvider = self.dataProvider,
            let data = dataProvider.data
        else {
            throw ImageDownloaderError.cgImageDataFail
        }
        
        let length = CFDataGetLength(data)
        let bytes = UnsafeMutablePointer<UInt8>.allocate(capacity: length)
        CFDataGetBytes(
            data,
            CFRange(location: 0, length: length),
            bytes
        )
        
        guard let context = CGContext(
            data: bytes,
            width: self.width,
            height: self.height,
            bitsPerComponent: self.bitsPerComponent,
            bytesPerRow: self.bytesPerRow,
            space: self.colorSpace ?? CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: self.bitmapInfo.rawValue
        ) else {
            throw ImageDownloaderError.createCGContextFail
        }
        
        completion(context)
        guard let image = context.makeImage() else {
            throw ImageDownloaderError.createCGImageFail
        }
        bytes.deallocate()
        return image
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
