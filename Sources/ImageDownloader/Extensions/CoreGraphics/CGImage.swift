//
//  CGImage.swift
//
//
//  Created by Илья Шаповалов on 22.09.2023.
//

import CoreGraphics

extension CGImage {
    var size: CGSize {
        .init(
            width: self.width.cgFloat,
            height: self.height.cgFloat
        )
    }
}
