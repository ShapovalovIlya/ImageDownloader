//
//  File.swift
//  
//
//  Created by Илья Шаповалов on 23.09.2023.
//

import Foundation

public enum ImageDownloaderError: Error, LocalizedError {
    case createCGImageFail
    case createCGContextFail
    case cgImageDataFail
    
    public var errorDescription: String? {
        switch self {
        case .createCGImageFail: return "Failed to make image from CGContext"
        case .createCGContextFail: return "Could not create context. Try different image parameters."
        case .cgImageDataFail: return "Could not get cgImage.dataProvider or underlined dataProvider.data"
        }
    }
}
