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
        /// Represent "textual" elements,
        /// including `String`, `Character`, `CharacterClass`, and `Anchor`.
        case text = 0
        
        /// Represent "counting" behaviors,
        /// including `ZeroOrMore`, `OneOrMore`, `Optionally`, `Repeat`, and `One`.
        case quantifier = 1
        
        /// Represent or affect "capturing" behaviors,
        case capture = 2
        
        /// Foundation parsers
        case foundation = 3
        
        /// Color for blocks representing other behaviours.
        case other = 4
    }
}

public extension ComponentModel.Section {
    var color: Color {
        switch self {
        case .text:
            return .orange
        case .quantifier:
            return .purple
        case .capture:
            return .green
        case .foundation:
            return .gray
        case .other:
            return .blue
        }
    }
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
        
        /// Foundation
        case dateTime
        case currency
        case decimal
        case wholeNumber
        case decimalPercentage
        case wholeNumberPercentage
        case url
        
        /// Others
        case lookahead
        case negativeLookahead
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
            case .dateTime:
                return "Date / Time"
            case .currency:
                return "Currency"
            case .decimal:
                return "Decimal"
            case .wholeNumber:
                return "Whole Number"
            case .decimalPercentage:
                return "Decimal Percentage"
            case .wholeNumberPercentage:
                return "Whole Number Percentage"
            case .url:
                return "URL"
            case .lookahead:
                return "Lookahead"
            case .negativeLookahead:
                return "Negative Lookahead"
            case .choiceOf:
                return "Choice Of"
            }
        }
        
        public func createNew() -> ComponentModel {
            switch self {
            case .string:
                return .string(.createNew())
            case .anchor:
                return .anchor(.createNew())
            case .zeroOrMore:
                return .zeroOrMore(.createNew())
            case .oneOrMore:
                return .oneOrMore(.createNew())
            case .optionally:
                return .optionally(.createNew())
            case .repeat:
                return .repeat(.createNew())
            case .dateTime:
                return .dateTime(.createNew())
            case .currency:
                return .currency(.createNew())
            case .decimal:
                return .decimal(.createNew())
            case .wholeNumber:
                return .wholeNumber(.createNew())
            case .decimalPercentage:    
                return .decimalPercentage(.createNew())
            case .wholeNumberPercentage:
                return .wholeNumberPercentage(.createNew())
            case .url:
                return .url(.createNew())
            case .lookahead:
                return .lookahead(.createNew())
            case .negativeLookahead:
                return .negativeLookahead(.createNew())
            case .choiceOf:
                return .choiceOf(.createNew())
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
        case .dateTime:
            return .dateTime
        case .currency:
            return .currency
        case .decimal:
            return .decimal
        case .wholeNumber:
            return .wholeNumber
        case .decimalPercentage:
            return .decimalPercentage
        case .wholeNumberPercentage:
            return .wholeNumberPercentage
        case .url:
            return .url
        case .lookahead:
            return .lookahead
        case .negativeLookahead:
            return .negativeLookahead
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
        case .dateTime, .currency, .decimal, .wholeNumber, .decimalPercentage, .wholeNumberPercentage, .url:
            return .foundation
        case .lookahead, .negativeLookahead, .choiceOf:
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
