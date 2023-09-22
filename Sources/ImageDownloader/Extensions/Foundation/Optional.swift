//
//  Optional.swift
//
//
//  Created by Илья Шаповалов on 22.09.2023.
//

import Foundation
import Combine

extension Optional {
    var throwingPublisher: AnyPublisher<Wrapped, Error> {
        switch self {
        case .none:
            return Fail(
                outputType: Wrapped.self,
                failure: CocoaError(.fileNoSuchFile)
            )
            .eraseToAnyPublisher()
        case .some(let wrapped):
            return Just(wrapped)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
