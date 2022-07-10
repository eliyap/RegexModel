//
//  BoundedRegex.swift
//  
//
//  Created by Secret Asian Man Dev on 9/7/22.
//

import Foundation
import RegexBuilder

/// Encodes information about captured types in an enum, instead of the type signature.
/// This allows us to know that a `Date` string was captured, without writing `Regex<Substring, Date>`.
/// Since each type would need `Optional` variants, we would have `12^arity` overloads!
/// Instead, by only having `Substring` and `Substring?` in the type signature, we have `2^arity` overloads.
public enum CapturedType: Int, Codable, Hashable, CaseIterable {
    case substring = 0
    case date      = 1
    case int       = 2
    case double    = 3
    case decimal   = 4
    case url       = 5
}

public enum BoundedRegex {
    
    case placeholder
    
    public enum Problem: Error {
        case tooManyCaptures
    }
}
