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
    
    func imageCancellable(
        for url: URL,
        options: [Option] = .init(),
        cache: CGImageCacheProtocol? = nil,
        completion: @escaping (Completion) -> Void = { _ in }
    ) -> AnyCancellable {
        return CGImageSession(
            processor: ProcessorConveyor(options),
            cache: cache ?? CGImageCache.shared
        )
        .cgImageTaskPublisher(for: url)
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
