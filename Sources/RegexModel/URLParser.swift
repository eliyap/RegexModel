//
//  File.swift
//  
//
//  Created by Secret Asian Man Dev on 10/7/22.
//

import Foundation
import RegexBuilder

#warning("consider offering full API to users")
public struct URLParameter: RegexParameter {
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .url

    public init() {
    }

    public static func createNew() -> URLParameter {
        .init()
    }

    public func regex() throws -> Regex<Substring> {
        
        Regex {
            "" /// Tricks compiler into using `Substring`.
            One(.url())
        }
    }
}
