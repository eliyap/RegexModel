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
