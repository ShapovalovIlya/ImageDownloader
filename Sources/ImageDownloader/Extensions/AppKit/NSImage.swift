//
//  NSImage.swift
//  
//
//  Created by Илья Шаповалов on 22.09.2023.
//

import AppKit

extension NSImage {
    convenience init(cgImage: CGImage) {
        self.init(cgImage: cgImage, size: .zero)
    }
}
