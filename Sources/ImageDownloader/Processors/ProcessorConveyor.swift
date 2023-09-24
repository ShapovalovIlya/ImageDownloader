//
//  ProcessorConveyor.swift
//  
//
//  Created by Илья Шаповалов on 22.09.2023.
//

import Foundation
import CoreGraphics
import AppKit

struct ProcessorConveyor {
    private let processors: [Option]
    
    //MARK: - init(_:)
    init(_ processors: [Option] = .init()) {
        self.processors = processors
    }
    
    //MARK: - Public methods
    func applyProcessors(_ cgImage: CGImage) throws -> CGImage {
        try processors.reduce(into: cgImage) { image, processor in
            image = try processor.process(image)
        }
    }
}
