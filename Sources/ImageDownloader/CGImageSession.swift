//
//  CGImageSession.swift
//  
//
//  Created by Илья Шаповалов on 22.09.2023.
//

import Foundation
import CoreGraphics
import Combine

struct CGImageSession {
    private let processor: ProcessorConveyor
    private let cache: CGImageCacheProtocol
    
    init(
        processor: ProcessorConveyor,
        cache: CGImageCacheProtocol
    ) {
        self.processor = processor
        self.cache = cache
    }
    
    func cgImageTaskPublisher(for url: URL) -> AnyPublisher<CGImage, Error> {
        cache.image(forUrl: url)
            .throwingPublisher
            .catch(cgImageTaskPublisher(for: url))
            .tryMap(processor.applyProcessors)
            .eraseToAnyPublisher()
    }
    
    private func cgImageTaskPublisher(for url: URL) -> (Error) -> AnyPublisher<CGImage, Error> {
        { _ in
            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .tryMap(CGImage.create(from:))
                .eraseToAnyPublisher()
        }
    }
}
