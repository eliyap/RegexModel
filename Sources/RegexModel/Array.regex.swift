//
//  File.swift
//  
//
//  Created by Secret Asian Man Dev on 30/6/22.
//

import Foundation
import RegexBuilder

/// Extension on `Array`, `ArraySlice`.
public extension RandomAccessCollection where Element == ComponentModel, Index == Int {
    /// Loose analogy to static `@resultBuilder`, this allows runtime combination of arbitrary numbers of generic regex components.
    func regex() -> Regex<Substring> {
        if isEmpty {
            return Regex { }
        } else {
            return Regex {
                self[startIndex].regex()
                self[(startIndex+1)..<endIndex].regex()
            }
        }
    }
}

public extension RandomAccessCollection where Element == ComponentModel, Index == Int {
    func choice() -> Regex<Substring> {
        /// An empty `ChoiceOf` is a compilation error in Swift, but a valid state in our model.
        /// Represent this invalid state as an empty regex.
        guard isEmpty == false else { return Regex { } }
        
        /// Loose analogy to `@AlternationBuilder`, allows runtime combination of arrays.
        func build() -> ChoiceOf<Substring> {
            if count == 1 {
                return ChoiceOf {
                    self[startIndex].regex()
                }
            } else {
                return ChoiceOf {
                    self[startIndex].regex()
                    self[(startIndex+1)..<endIndex].choice()
                }
            }
        }
        
        return Regex { build() }
    }
}
