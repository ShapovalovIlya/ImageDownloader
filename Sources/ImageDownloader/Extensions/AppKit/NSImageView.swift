//
//  NSImageView.swift
//
//
//  Created by Илья Шаповалов on 22.09.2023.
//

import AppKit
import Combine
import CoreGraphics

public extension NSImageView {
    typealias Completion = Subscribers.Completion<Error>
    
    func image(
        for url: URL,
        cache: CGImageCacheProtocol? = nil,
        completion: @escaping (Completion) -> Void = { _ in }
    ) -> AnyCancellable {
        let processor = ImageProcessor(
            .resize(self.bounds.size),
            .cornerRadius(24)
        )
        
        return CGImageSession(
            processor: processor,
            cache: cache ?? CGImageCache.shared
        )
        .cgImageTaskPublisher(for: url, in: self.bounds.size)
        .map(NSImage.init(cgImage:))
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: completion,
            receiveValue: set(image:)
        )
    }
}

private extension NSImageView {
    func set(image: NSImage) {
        self.image = image
    }
}
