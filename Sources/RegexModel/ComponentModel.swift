//
//  ComponentModel.swift
//  RegexModel
//
//  Created by Secret Asian Man Dev on 30/6/22.
//

import Foundation
import RegexBuilder

public enum ComponentModel: Codable {
    /// Literals
    case string(StringParameter)
    
    /// Quantifiers
    case zeroOrMore(ZeroOrMoreParameter)
    case oneOrMore(OneOrMoreParameter)
    case optionally(OptionallyParameter)
    case `repeat`(RepeatParameter)
    
    /// Captures
    case capture(CaptureParameter)
    
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
        case .capture(let params):
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
