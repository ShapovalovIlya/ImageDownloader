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
        countLimit: Int = 50
    ) {
        self.logger = logger
        cache.countLimit = countLimit
    }
    
    //MARK: - Public methods
    public func setImage(_ image: CGImage, forUrl url: URL) {
        logger?.debug(#function)
        cache.setObject(image, forKey: url as NSURL)
    }
    
    public func image(forUrl url: URL) -> CGImage? {
        logger?.debug(#function)
        return cache.object(forKey: url as NSURL)
    }
    
    static func shared(logger: Logger? = nil) -> CGImageCache {
        CGImageCache(logger: logger)
    }
}
