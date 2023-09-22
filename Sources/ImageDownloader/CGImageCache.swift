//
//  File.swift
//  
//
//  Created by Илья Шаповалов on 22.09.2023.
//

import Foundation
import CoreGraphics
import OSLog

public protocol CGImageCacheProtocol: AnyObject {
    init(logger: Logger?, countLimit: Int)
    
    func setImage(_ image: CGImage, forUrl url: URL)
    func image(forUrl url: URL) -> CGImage?
}

final class CGImageCache: CGImageCacheProtocol {
    //MARK: - Public properties
    public static let shared = CGImageCache()
    
    //MARK: - Private properties
    private let cache = NSCache<NSURL, CGImage>()
    private let logger: Logger?
    
    //MARK: - init(_:)
    required internal init(
        logger: Logger? = nil,
        countLimit: Int = 30
    ) {
        self.logger = logger
        cache.countLimit = countLimit
    }
    
    //MARK: - Public methods
    public func setImage(_ image: CGImage, forUrl url: URL) {
        logger?.debug("\(#function)")
        guard let nsurl = NSURL(string: url.absoluteString) else {
            return
        }
        cache.setObject(image, forKey: nsurl)
    }
    
    public func image(forUrl url: URL) -> CGImage? {
        guard
            let nsurl = NSURL(string: url.absoluteString),
            let image = cache.object(forKey: nsurl)
        else {
            logger?.debug("Unable to load image from cache")
            return nil
        }
        logger?.debug("Load image from cache")
        return image
    }
    
    static func shared(logger: Logger? = nil) -> CGImageCache {
        CGImageCache(logger: logger)
    }
}
