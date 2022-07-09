//
//  RepetitionBehavior.swift
//  
//
//  Created by Secret Asian Man Dev on 8/7/22.
//

import RegexBuilder

public enum RepetitionBehavior: Int, Hashable, Codable, CaseIterable {
    case reluctant  = 0
    case eager      = 1
    case possessive = 2
    
    var behavior: RegexRepetitionBehavior {
        switch self {
        case .reluctant:
            return .reluctant
        case .eager:
            return .eager
        case .possessive:
            return .possessive
        }
    }
}
