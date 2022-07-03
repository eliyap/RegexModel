//
//  Section.swift
//  
//
//  Created by Secret Asian Man Dev on 3/7/22.
//

import Foundation
import SwiftUI

public extension ComponentModel {
    enum Section: CaseIterable {
        /// Color for blocks representing "textual" elements,
        /// including `String`, `Character`, `CharacterClass`, and `Anchor`.
        case text
        
        /// Color for blocks representing "counting" behaviors,
        /// including `ZeroOrMore`, `OneOrMore`, `Optionally`, `Repeat`, and `One`.
        case quantifier
        
        /// Color for blocks representing or affecting "capturing" behaviors,
        case capture
        
        /// Color for blocks representing other behaviours.
        case other
    }
    
    var section: Section {
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
