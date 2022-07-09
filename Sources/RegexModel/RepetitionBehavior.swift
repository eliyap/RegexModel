//
//  RepetitionBehavior.swift
//  
//
//  Created by Secret Asian Man Dev on 8/7/22.
//

import RegexBuilder

/// A database friendly `enum` representation of the underlying `struct`.
public enum RepetitionBehavior: Int, Hashable, Codable, CaseIterable {
    case reluctant  = 0
    case eager      = 1
    case possessive = 2
    
    var behavior: RegexRepetitionBehavior {
        switch self {
        case .reluctant:
            return .reluctant
        case .eager:
            return .eager
        case .possessive:
            return .possessive
        }
    }
    
    init?(behavior: RegexRepetitionBehavior) {
        switch behavior {
        case .reluctant:
            self = .reluctant
        case .eager:
            self = .eager
        case .possessive:
            self = .possessive
        default:
            assert(false, "Unknown behavior value!")
            return nil
        }
    }
    
    var `default`: Self { .init(behavior: .default)! }
}
