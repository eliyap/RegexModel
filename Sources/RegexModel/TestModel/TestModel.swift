//
//  TestModel.swift
//  
//
//  Created by Secret Asian Man Dev on 4/7/22.
//

import Foundation

public struct TestModel {
    public let id: String = UUID().uuidString
    public var name: String
    public var string: String
    public var matchMode: MatchMode = .default
    
    public func test(against regex: Regex<Substring>) throws -> [Substring] {
        switch matchMode {
        case .wholeString:
            if let match = try regex.wholeMatch(in: string) {
                return [match.output]
            } else {
                return []
            }
        
        case .allMatches:
            var remaining: Substring = Substring(string)
            var matches: [Substring] = []
            while let match = try regex.firstMatch(in: remaining) {
                guard match.output.count > 0 else { break }
                matches.append(match.output)
                remaining = remaining[match.endIndex..<remaining.endIndex]
                print(remaining)
            }
            return matches
        }
    }
    
    public static let example: Self = .init(name: "Example", string: "My car has a scar in the carpet!", matchMode: .allMatches)
}

extension TestModel: Hashable { }

public enum MatchMode: Int, CaseIterable {
    case wholeString
    case allMatches
    
    static var `default`: Self = .wholeString
}
