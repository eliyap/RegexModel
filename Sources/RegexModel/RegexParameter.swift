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
public protocol RegexParameter: Hashable, Identifiable, Codable {
    
    var id: String { get }
    
    var proxy: ComponentModel.Proxy { get }
    
    /// Explicitly generate a new parameter struct.
    static func createNew() -> Self
    
    /// Construct the component from the parameters.
    /// Since `Regex<Substring>` is a concrete implementation of the `RegexComponent` protocol,
    /// it is a good choice to acheive "type erasure".
    func regex() -> Regex<Substring>
    #warning("revisit when AnyRegexOutput is working")
}

// MARK: - Literals
/// `Character` omitted.
public struct StringParameter: RegexParameter {
    
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .string
    
    public var string: String
    
    public init(string: String) {
        self.string = string
    }
    
    public static func createNew() -> StringParameter {
        .init(string: "")
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            string
        }
    }
}

// MARK: - Quantifiers
/// `One` omitted, I don't see the point
extension RegexRepetitionBehavior {
    /// Based on snippets from proposal
    /// https://github.com/apple/swift-experimental-string-processing/blob/main/Documentation/Evolution/RegexBuilderDSL.md#quantification
    public static let `default`: RegexRepetitionBehavior = .eager
}

public struct ZeroOrMoreParameter: RegexParameter {
    
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .zeroOrMore
    
    public var behavior: RepetitionBehavior
    public var components: [ComponentModel]
    
    public init(behavior: RepetitionBehavior = .default, components: [ComponentModel]) {
        self.behavior = behavior
        self.components = components
    }
    
    public static func createNew() -> ZeroOrMoreParameter {
        .init(behavior: .default, components: [])
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            ZeroOrMore(behavior.behavior) {
                components.regex()
            }
        }
    }
}

public struct OneOrMoreParameter: RegexParameter {
    
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .oneOrMore
    
    public var behavior: RepetitionBehavior
    public var components: [ComponentModel]
    
    public init(behavior: RepetitionBehavior = .default, components: [ComponentModel]) {
        self.behavior = behavior
        self.components = components
    }
    
    public static func createNew() -> OneOrMoreParameter {
        .init(behavior: .default, components: [])
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            OneOrMore(behavior.behavior) {
                components.regex()
            }
        }
    }
}

public struct OptionallyParameter: RegexParameter {
    
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .optionally
    
    public var behavior: RepetitionBehavior = .default
    public var components: [ComponentModel]
    
    public init(behavior: RepetitionBehavior = .default, components: [ComponentModel]) {
        self.behavior = behavior
        self.components = components
    }
    
    public static func createNew() -> OptionallyParameter {
        .init(behavior: .default, components: [])
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            Optionally(behavior.behavior) {
                components.regex()
            }
        }
    }
}

public struct RepeatParameter: RegexParameter {
    
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .repeat
    
    public var range: Range<Int>
    public var behavior: RepetitionBehavior = .default
    public var components: [ComponentModel]
    
    public init(range: Range<Int>, behavior: RepetitionBehavior = .default, components: [ComponentModel]) {
        self.range = range
        self.behavior = behavior
        self.components = components
    }
    
    public static func createNew() -> RepeatParameter {
        .init(range: 1..<2, behavior: .default, components: [])
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            Repeat(range, behavior.behavior) {
                components.regex()
            }
        }
    }
}

#warning("TODO: revisit when AnyRegexOuput works")
//// MARK: - Captures
//public struct CaptureParameter: RegexParameter {
//
//    public static func == (lhs: CaptureParameter, rhs: CaptureParameter) -> Bool {
//        lhs.id == rhs.id && lhs.components == rhs.components
//    }
//
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//        hasher.combine(components)
//    }
//
//    public let id = UUID().uuidString
//
//    public let reference: RegexBuilder.Reference<Substring>
//
//    public var components: [ComponentModel]
//
//    public func regex() -> Regex<Substring> {
//        Regex {
//            Capture(as: reference) { components.regex() }
//        }
//    }
//
//    public func _regex() -> Regex<(Substring, Substring)> {
//        Regex {
//            Capture(as: reference) { components.regex() }
//        }
//    }
//}

// MARK: - Others
public struct LookaheadParameter: RegexParameter {
    
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .lookahead
    
    public var components: [ComponentModel]
    
    public init(components: [ComponentModel]) {
        self.components = components
    }
    
    public static func createNew() -> LookaheadParameter {
        .init(components: [])
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            Lookahead {
                components.regex()
            }
        }
    }
}

public struct NegativeLookaheadParameter: RegexParameter {
    
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .negativeLookahead
    
    public var components: [ComponentModel]
    
    public init(components: [ComponentModel]) {
        self.components = components
    }
    
    public static func createNew() -> NegativeLookaheadParameter {
        .init(components: [])
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            NegativeLookahead {
                components.regex()
            }
        }
    }
}

public struct ChoiceOfParameter: RegexParameter {
    
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .choiceOf
    
    public var components: [ComponentModel]
    
    public init(components: [ComponentModel]) {
        self.components = components
    }
    
    public static func createNew() -> ChoiceOfParameter {
        .init(components: [])
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
    public enum Boundary: Int, CaseIterable, Codable, Hashable {
        case endOfLine
        case endOfSubject
        case endOfSubjectBeforeNewline
        case firstMatchingPositionInSubject
        case startOfLine
        case startOfSubject
        case textSegmentBoundary
        case wordBoundary
        
        public static let `default`: Self = .wordBoundary
        
        public var displayTitle: String {
            switch self {
            case .endOfLine:
                return "End of Line"
            case .endOfSubject:
                return "End of Subject"
            case .endOfSubjectBeforeNewline:
                return "End of Subject Before Newline"
            case .firstMatchingPositionInSubject:
                return "First Matching Position in Subject"
            case .startOfLine:
                return "Start of Line"
            case .startOfSubject:
                return "Start of Subject"
            case .textSegmentBoundary:
                return "Text Segment Boundary"
            case .wordBoundary:
                return "Word Boundary"
            }
        }
        
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
    
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .anchor
    
    public var boundary: Boundary
    
    public init(boundary: Boundary) {
        self.boundary = boundary
    }
    
    public static func createNew() -> AnchorParameter {
        .init(boundary: .default)
    }
    
    public func regex() -> Regex<Substring> {
        Regex {
            boundary.anchor
        }
    }
}
