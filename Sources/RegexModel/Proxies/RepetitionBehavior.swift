//
//  RepetitionBehavior.swift
//  
//
//  Created by Secret Asian Man Dev on 8/7/22.
//

import RegexBuilder

/// A database friendly `enum` representation of the underlying `struct`.
public enum RepetitionBehavior: Int, Hashable, Codable, CaseIterable, Sendable {
    case reluctant  = 0
    case eager      = 1
    case possessive = 2
    
    public var behavior: RegexRepetitionBehavior {
        switch self {
        case .reluctant:
            return .reluctant
        case .eager:
            return .eager
        case .possessive:
            return .possessive
        }
    }
    
    public init?(behavior: RegexRepetitionBehavior) {
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
    
    public var displayTitle: String { behavior.displayTitle }
    
    public static var `default`: Self { .init(behavior: .default)! }
}

public extension RegexRepetitionBehavior {
    var displayTitle: String {
        switch self {
        case .reluctant:
            return "Reluctant"
        case .eager:
            return "Eager"
        case .possessive:
            return "Possessive"
        default:
            assert(false, "Unknown behavior case")
            return "Unknown"
        }
    }
}

extension RegexRepetitionBehavior {
    /// Based on snippets from proposal
    /// https://github.com/apple/swift-experimental-string-processing/blob/main/Documentation/Evolution/RegexBuilderDSL.md#quantification
    public static let `default`: RegexRepetitionBehavior = .eager
}
