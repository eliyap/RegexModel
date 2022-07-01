//
//  RegexParameter.swift
//  
//
//  Created by Secret Asian Man Dev on 30/6/22.
//

import Foundation
import RegexBuilder

/// Describes requirements for a `RegexComponent`'s parameters,
/// e.g. a string regex needs a string.
/// - Note: `Hashable` required for `ForEach` conformance.
@available(macOS 13.0, iOS 16, *)
public protocol RegexParameter: Hashable, Identifiable {
    /// Construct the component from the parameters.
    /// Since `Regex<Substring>` is a concrete implementation of the `RegexComponent` protocol,
    /// it is a good choice to acheive "type erasure".
    func regex() -> Regex<Substring>
    #warning("revisit when AnyRegexOutput is working")
}

// MARK: - Literals
/// `Character` omitted.
public struct StringParameter: RegexParameter {
    
    public let id = UUID().uuidString
    
    public var string: String
    
    public init(string: String) {
        self.string = string
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            string
        }
    }
}

// MARK: - Quantifiers
/// `One` omitted, I don't see the point
public struct ZeroOrMoreParameter: RegexParameter {
    
    public let id = UUID().uuidString
    
    public var behaviour: RegexRepetitionBehavior? = nil
    public var components: [ComponentModel]
    
    public init(behaviour: RegexRepetitionBehavior? = nil, components: [ComponentModel]) {
        self.behaviour = behaviour
        self.components = components
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            ZeroOrMore(behaviour) {
                components.regex()
            }
        }
    }
}

public struct OneOrMoreParameter: RegexParameter {
    
    public let id = UUID().uuidString
    
    public var behaviour: RegexRepetitionBehavior? = nil
    public var components: [ComponentModel]
    
    public init(behaviour: RegexRepetitionBehavior? = nil, components: [ComponentModel]) {
        self.behaviour = behaviour
        self.components = components
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            OneOrMore(behaviour) {
                components.regex()
            }
        }
    }
}

public struct OptionallyParameter: RegexParameter {
    
    public let id = UUID().uuidString
    
    public var behaviour: RegexRepetitionBehavior? = nil
    public var components: [ComponentModel]
    
    public init(behaviour: RegexRepetitionBehavior? = nil, components: [ComponentModel]) {
        self.behaviour = behaviour
        self.components = components
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            Optionally(behaviour) {
                components.regex()
            }
        }
    }
}

public struct RepeatParameter: RegexParameter {
    
    public let id = UUID().uuidString
    
    public var range: Range<Int>
    public var behaviour: RegexRepetitionBehavior? = nil
    public var components: [ComponentModel]
    
    public init(range: Range<Int>, behaviour: RegexRepetitionBehavior? = nil, components: [ComponentModel]) {
        self.range = range
        self.behaviour = behaviour
        self.components = components
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            Repeat(range, behaviour) {
                components.regex()
            }
        }
    }
}

// MARK: - Others
public struct LookaheadParameter: RegexParameter {
    #warning("under development")
    public let id = UUID().uuidString
    
    public var negative: Bool
    
    public var components: [ComponentModel]
    
    public func regex() -> Regex<Substring> {
        Regex {
            Lookahead(negative: negative) {
                components.regex()
            }
        }
    }
}

public struct ChoiceOfParameter: RegexParameter {
    
    public let id = UUID().uuidString
    
    public var components: [ComponentModel]
    
    public init(components: [ComponentModel]) {
        self.components = components
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            components.choice()
        }
    }
}

public struct AnchorParameter: RegexParameter {
    
    /// Thin wrapper enum around static vars.
    /// Mirrors internal `Kind` at source https://github.com/apple/swift-experimental-string-processing/blob/290ce1060beb906e62ac54d4debf13cfbb992b6b/Sources/RegexBuilder/Anchor.swift
    public enum Boundary {
        case endOfLine
        case endOfSubject
        case endOfSubjectBeforeNewline
        case firstMatchingPositionInSubject
        case startOfLine
        case startOfSubject
        case textSegmentBoundary
        case wordBoundary
        
        public var anchor: Anchor {
            switch self {
            case .endOfLine:
                return .endOfLine
            case .endOfSubject:
                return .endOfSubject
            case .endOfSubjectBeforeNewline:
                return .endOfSubjectBeforeNewline
            case .firstMatchingPositionInSubject:
                return .firstMatchingPositionInSubject
            case .startOfLine:
                return .startOfLine
            case .startOfSubject:
                return .startOfSubject
            case .textSegmentBoundary:
                return .textSegmentBoundary
            case .wordBoundary:
                return .wordBoundary
            }
        }
    }
    
    public let id = UUID().uuidString
    
    public var boundary: Boundary
    
    public func regex() -> Regex<Substring> {
        Regex {
            boundary.anchor
        }
    }
}
