//
//  MatchAll.swift
//  
//
//  Created by Secret Asian Man Dev on 18/7/22.
//

import Foundation

public extension Regex {
    func allMatches(in string: String) throws -> [Output] {
        var remaining: Substring = Substring(string)
        var matches: [Output] = []
        while let match = try firstMatch(in: remaining), let range = remaining.firstRange(of: { self }) {
            guard isValid(output: match.output) else { break }
            matches.append(match.output)
            remaining = remaining[range.upperBound..<remaining.endIndex]
            print(remaining, match.output, string[range])
        }
        return matches
    }
}

fileprivate extension Regex {
    func isValid(output: Output) -> Bool {
        return true
    }
}

/// Ensure that substring match is always advancing, to avoid an infinite loop.
fileprivate extension Regex where Output == Substring {
    func isValid(output: Output) -> Bool {
        return output.count > 0
    }
}
