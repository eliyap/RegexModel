//
//  ComponentModel.swift
//  RegexModel
//
//  Created by Secret Asian Man Dev on 30/6/22.
//

import Foundation
import RegexBuilder

public enum ComponentModel {
    /// Literals
    case string(StringParameter)
    
    /// Quantifiers
    case zeroOrMore(ZeroOrMoreParameter)
    case oneOrMore(OneOrMoreParameter)
    case optionally(OptionallyParameter)
    case `repeat`(RepeatParameter)
    
    /// Others
    case lookahead(LookaheadParameter)
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

        case .lookahead(let lookaheadParameter):
            return lookaheadParameter.regex()

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
        case .string(let stringParameter):
            return stringParameter.id
        case .zeroOrMore(let zeroOrMoreParameter):
            return zeroOrMoreParameter.id
        case .oneOrMore(let oneOrMoreParameter):
            return oneOrMoreParameter.id
        case .optionally(let optionallyParameter):
            return optionallyParameter.id
        case .repeat(let repeatParameter):
            return repeatParameter.id
        case .lookahead(let lookaheadParameter):
            return lookaheadParameter.id
        case .choiceOf(let choiceOfParameter):
            return choiceOfParameter.id
        case .anchor(let anchorParameter):
            return anchorParameter.id
        }
    }
}
