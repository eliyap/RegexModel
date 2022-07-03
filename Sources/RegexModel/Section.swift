//
//  Section.swift
//  
//
//  Created by Secret Asian Man Dev on 3/7/22.
//

import Foundation
import SwiftUI

public extension ComponentModel {
    enum Section: Int, CaseIterable, Codable {
        /// Color for blocks representing "textual" elements,
        /// including `String`, `Character`, `CharacterClass`, and `Anchor`.
        case text = 0
        
        /// Color for blocks representing "counting" behaviors,
        /// including `ZeroOrMore`, `OneOrMore`, `Optionally`, `Repeat`, and `One`.
        case quantifier = 1
        
        /// Color for blocks representing or affecting "capturing" behaviors,
        case capture = 2
        
        /// Color for blocks representing other behaviours.
        case other = 3
    }
}

public extension Color {
    /// Color for blocks representing "textual" elements,
    /// including `String`, `Character`, `CharacterClass`, and `Anchor`.
    static var text: Color { .orange }
    
    /// Color for blocks representing "counting" behaviors,
    /// including `ZeroOrMore`, `OneOrMore`, `Optionally`, `Repeat`, and `One`.
    static var quantifier: Color { .purple }
    
    /// Color for blocks representing or affecting "capturing" behaviors,
    static var capture: Color { .green }
    
    /// Color for blocks representing other behaviours.
    static var other: Color { .blue }
}

public extension ComponentModel {
    /// Represents the models without the associated values, for table purposes.
    enum Proxy: String, CaseIterable, Codable {
        /// Text
        case string
        case anchor
        
        /// Quantifiers
        case zeroOrMore
        case oneOrMore
        case optionally
        case `repeat`
        
        /// Others
        case lookahead
        case choiceOf   
        
        public var displayTitle: String {
            switch self {
            case .string:
                return "String"
            case .anchor:
                return "Anchor"
            case .zeroOrMore:
                return "Zero Or More"
            case .oneOrMore:
                return "One Or More"
            case .optionally:
                return "Optionally"
            case .repeat:
                return "Repeat"
            case .lookahead:
                return "Lookahead"
            case .choiceOf:
                return "Choice Of"
            }
        }
    }
    
    var proxy: Proxy {
        switch self {
        case .string:
            return .string
        case .zeroOrMore:
            return .zeroOrMore
        case .oneOrMore:
            return .oneOrMore
        case .optionally:
            return .optionally
        case .repeat:
            return .repeat
        case .lookahead:
            return .lookahead
        case .choiceOf:
            return .choiceOf
        case .anchor:
            return .anchor
        }
    }
}

public extension ComponentModel.Proxy {
    var section: ComponentModel.Section {
        switch self {
        case .string, .anchor:
            return .text
        case .zeroOrMore, .oneOrMore, .optionally, .repeat:
            return .quantifier
        case .lookahead, .choiceOf:
            return .other
        }
    }
}

public extension ComponentModel.Section {
    /// Array type guarantees a stable order, specifically declaration order.
    var proxyItems: [ComponentModel.Proxy] {
        ComponentModel.Proxy.allCases.filter { $0.section == self }
    }
}
