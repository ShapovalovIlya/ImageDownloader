//
//  File.swift
//  
//
//  Created by Илья Шаповалов on 23.09.2023.
//

import Foundation
import CoreGraphics

public enum Option {
    case resizeTo(CGSize)
    case cornerRadius(CGFloat)
    case cacheFor(URL)
    
    //MARK: - Public methods
    func process(_ cgImage: CGImage) throws -> CGImage {
        switch self {
        case let .resizeTo(size): 
            return try ResizeProcessor(to: size).process(cgImage)
            
        case let .cornerRadius(radius):
            return try RoundCornerProcessor(radius).process(cgImage)
            
        case let .cacheFor(url):
            CGImageCache.shared.setImage(cgImage, forUrl: url)
            return cgImage
        }
    }
}
