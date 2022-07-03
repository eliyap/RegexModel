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
    enum Proxy: Int, CaseIterable, Codable {
        /// Text
        case string     = 0
        case anchor     = 1
        
        /// Quantifiers
        case zeroOrMore = 2
        case oneOrMore  = 3
        case optionally = 4
        case `repeat`   = 5
        
        /// Others
        case lookahead  = 6
        case choiceOf   = 7
    }
}

extension ComponentModel.Proxy {
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

extension ComponentModel.Section {
    /// Array type guarantees a stable order, specifically declaration order.
    var proxyItems: [ComponentModel.Proxy] {
        ComponentModel.Proxy.allCases.filter { $0.section == self }
    }
}
