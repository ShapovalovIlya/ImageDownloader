//
//  File.swift
//  
//
//  Created by Илья Шаповалов on 23.09.2023.
//

import Foundation
import CoreGraphics

public enum Processor {
    case resize(CGSize)
    case cornerRadius(CGFloat)
    
    func process(_ cgImage: CGImage) throws -> CGImage {
        switch self {
        case let .resize(size): return try resize(size)(cgImage)
        case let .cornerRadius(radius): return try round(corner: radius)(cgImage)
        }
    }
}

private extension Processor {
    //MARK: - Private methods
    func resize(_ size: CGSize) -> (CGImage) throws -> CGImage {
        { cgImage in
            let context = try makeContext(
                from: cgImage,
                in: size,
                bitsPerComponent: cgImage.bitsPerComponent
            )
            context.interpolationQuality = .high
            context.draw(
                cgImage,
                in: .init(origin: .zero, size: size)
            )
            
            guard let scaled = context.makeImage() else {
                throw ProcessorError.createImageFail
            }
            return scaled
        }
    }
    
    func round(corner: CGFloat) -> (CGImage) throws -> CGImage {
        { cgImage in
            let rect = NSRect(origin: .zero, size: cgImage.size)
            let context = try makeContext(
                from: cgImage,
                in: rect.size,
                bitsPerComponent: cgImage.bitsPerComponent,
                bytesPerRow: 4 * rect.width.int
            )
            let path = makePath(in: rect, with: corner)
            draw(path, in: context)
            guard let cornered = context.makeImage() else {
                throw ProcessorError.createImageFail
            }
            return cornered
        }
    }
    
    func makePath(in rect: NSRect, with radius: CGFloat) -> CGPath {
        CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil)
    }
    
    func draw(_ path: CGPath, in context:CGContext) {
        context.beginPath()
        context.addPath(path)
        context.closePath()
        context.clip()
    }
    
    func makeContext(
        from cgImage: CGImage,
        in size: CGSize,
        bitsPerComponent: Int,
        bytesPerRow: Int = 8
    ) throws -> CGContext {
        guard let context = CGContext(
            data: nil,
            width: size.width.int,
            height: size.height.int,
            bitsPerComponent: bitsPerComponent,
            bytesPerRow: bytesPerRow,
            space: cgImage.colorSpace ?? CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: cgImage.bitmapInfo.rawValue
        ) else {
            throw ProcessorError.createContextFail
        }
        return context
    }
}
