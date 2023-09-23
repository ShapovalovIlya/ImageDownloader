//
//  RoundCornerProcessor.swift
//
//
//  Created by Илья Шаповалов on 23.09.2023.
//

import Foundation
import CoreGraphics

struct RoundCornerProcessor {
    private let radius: CGFloat
    
    init(_ radius: CGFloat) {
        self.radius = radius
    }
    
    func process(_ cgImage:CGImage) throws -> CGImage {
        let rect = NSRect(origin: .zero, size: cgImage.size)
        guard let context = cgImage.context else {
            throw ImageDownloaderError.createCGContextFail
        }
        let path = makePath(in: rect, with: radius)
        draw(path, in: context)
        guard let cornered = context.makeImage() else {
            throw ImageDownloaderError.createCGImageFail
        }
        return cornered
    }
    
}

private extension RoundCornerProcessor {
    //MARK: - Private methods
    func makePath(in rect: NSRect, with radius: CGFloat) -> CGPath {
        CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil)
    }
    
    func draw(_ path: CGPath, in context:CGContext) {
        context.beginPath()
        context.addPath(path)
        context.closePath()
        context.clip()
    }
}
