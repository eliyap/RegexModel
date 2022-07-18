//
//  MatchAll.swift
//  
//
//  Created by Secret Asian Man Dev on 18/7/22.
//

import Foundation

public extension Regex where Output == Substring {
    func allMatches(in string: String) throws -> [Substring] {
        var remaining: Substring = Substring(string)
        var matches: [Substring] = []
        while let match = try firstMatch(in: remaining) {
            guard match.output.count > 0 else { break }
            matches.append(match.output)
            remaining = remaining[match.endIndex..<remaining.endIndex]
            print(remaining)
        }
        return matches
    }
}
