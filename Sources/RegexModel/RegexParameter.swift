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
struct LookaheadParameter: RegexParameter {
    #warning("under development")
    public let id = UUID().uuidString
    
    public var components: [ComponentModel]
    
    func regex() -> Regex<Substring> {
        Regex {
            OneOrMore {
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

struct AnchorParameter: RegexParameter {
    #warning("under development")

    public let id = UUID().uuidString
    
    public var components: [ComponentModel]
    
    public func regex() -> Regex<Substring> {
        Regex {
            OneOrMore {
                components.regex()
            }
        }
    }
}
