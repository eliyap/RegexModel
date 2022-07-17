//
//  ComponentModel.swift
//  RegexModel
//
//  Created by Secret Asian Man Dev on 30/6/22.
//

import Foundation
import RegexBuilder

public enum ComponentModel: Codable, Sendable {
    /// Literals
    case string(StringParameter)
    
    /// Quantifiers
    case zeroOrMore(ZeroOrMoreParameter)
    case oneOrMore(OneOrMoreParameter)
    case optionally(OptionallyParameter)
    case `repeat`(RepeatParameter)

    /// Foundation
    case dateTime(DateTimeParameter)
    case currency(CurrencyParameter)
    case decimal(DecimalParameter)
    case wholeNumber(WholeNumberParameter)  
    case decimalPercentage(DecimalPercentageParameter)
    case wholeNumberPercentage(WholeNumberPercentageParameter)
    case url(URLParameter)
    
    /// Others
    case lookahead(LookaheadParameter)
    case negativeLookahead(NegativeLookaheadParameter)
    case choiceOf(ChoiceOfParameter)
    case anchor(AnchorParameter)
    
    func regex() -> Regex<Substring> {
        switch self {
        case .string(let stringParameter):
            return stringParameter.regex()
        
        case .zeroOrMore(let zeroOrMoreParameter):
            return zeroOrMoreParameter.regex()

        case .oneOrMore(let oneOrMoreParameter):
            return oneOrMoreParameter.regex()

        case .optionally(let optionallyParameter):
            return optionallyParameter.regex()

        case .repeat(let repeatParameter):
            return repeatParameter.regex()

        case .dateTime(let dateTimeParameter):
            return dateTimeParameter.regex()

        case .currency(let currencyParameter):
            return currencyParameter.regex()

        case .decimal(let decimalParameter):
            return decimalParameter.regex()

        case .wholeNumber(let wholeNumberParameter):
            return wholeNumberParameter.regex()

        case .decimalPercentage(let decimalPercentageParameter):
            return decimalPercentageParameter.regex()

        case .wholeNumberPercentage(let wholeNumberPercentageParameter):
            return wholeNumberPercentageParameter.regex()

        case .url(let urlParameter):
            return urlParameter.regex()

        case .lookahead(let lookaheadParameter):
            return lookaheadParameter.regex()
            
        case .negativeLookahead(let negativeLookaheadParameter):
            return negativeLookaheadParameter.regex()

        case .choiceOf(let choiceOfParameter):
            return choiceOfParameter.regex()

        case .anchor(let anchorParameter):
            return anchorParameter.regex()
        }
    }
}

extension ComponentModel: Equatable { }

extension ComponentModel: Hashable { }

extension ComponentModel: Identifiable {
    public var id: String {
        switch self {
        case .string(let params):
            return params.id
        case .zeroOrMore(let params):
            return params.id
        case .oneOrMore(let params):
            return params.id
        case .optionally(let params):
            return params.id
        case .repeat(let params):
            return params.id
        case .dateTime(let params):
            return params.id
        case .currency(let params):
            return params.id
        case .decimal(let params):
            return params.id
        case .wholeNumber(let params):
            return params.id
        case .decimalPercentage(let params):
            return params.id
        case .wholeNumberPercentage(let params):
            return params.id
        case .url(let params):
            return params.id
        case .lookahead(let params):
            return params.id
        case .negativeLookahead(let params):
            return params.id
        case .choiceOf(let params):
            return params.id
        case .anchor(let params):
            return params.id
        }
    }
}
