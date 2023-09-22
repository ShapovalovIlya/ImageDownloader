//
//  File.swift
//  
//
//  Created by Илья Шаповалов on 22.09.2023.
//

import Foundation
import CoreGraphics
import Combine

struct CGImageSession {
    private let processor: ImageProcessor
    private let cache: CGImageCacheProtocol
    
    init(
        processor: ImageProcessor,
        cache: CGImageCacheProtocol
    ) {
        self.processor = processor
        self.cache = cache
    }
    
    func cgImageTaskPublisher(for url: URL, in size: CGSize) -> AnyPublisher<CGImage, Error> {
        cache.image(forUrl: url)
            .throwingPublisher
            .catch(cachedCGImageTaskPublisher(for: url))
            .eraseToAnyPublisher()
    }
    
    func cachedCGImageTaskPublisher(for url: URL) -> (Error) -> AnyPublisher<CGImage, Error> {
        { _ in
            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .tryMap(ImageProcessor.createCGImage(from:))
                .map(cache(forUrl: url))
                .eraseToAnyPublisher()
        }
    }
}

private extension CGImageSession {
    private func cache(forUrl url: URL) -> (CGImage) -> CGImage {
        { cgImage in
            cache.setImage(cgImage, forUrl: url)
            return cgImage
        }
    }
}
