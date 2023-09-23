//
//  ResizeProcessor.swift
//  
//
//  Created by Илья Шаповалов on 23.09.2023.
//

import CoreGraphics

struct ResizeProcessor {
    private let size: CGSize
    
    init(to size: CGSize) {
        self.size = size
    }
    
    func process(_ cgImage: CGImage) throws -> CGImage {
        try cgImage.contextBody { context in
            context.interpolationQuality = .high
            context.draw(
                cgImage,
                in: .init(origin: .zero, size: size)
            )

        }
//        guard let context = cgImage.context else {
//            throw ImageDownloaderError.createCGContextFail
//        }
        //            guard let scaled = context.makeImage() else {
        //                throw ImageDownloaderError.createCGImageFail
        //            }
        //            return scaled
        
    }
}
