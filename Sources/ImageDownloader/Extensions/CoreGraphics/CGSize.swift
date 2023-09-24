//
//  CGSize.swift
//
//
//  Created by Илья Шаповалов on 24.09.2023.
//

import Foundation

extension CGSize {
    /// Scales current size with given scale factor
    /// - Parameter scale: Current screen scale factor
    /// - Returns: scaled size
    func scaled(with scale: CGFloat) -> CGSize {
        .init(
            width: self.width * scale,
            height: self.height * scale
        )
    }
}
