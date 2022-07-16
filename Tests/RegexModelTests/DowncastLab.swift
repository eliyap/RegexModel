//
//  File.swift
//  
//
//  Created by Secret Asian Man Dev on 14/7/22.
//

import XCTest
@testable import RegexModel

import RegexBuilder

final class DowncastLabTests: XCTestCase {
    func testAny() throws {
        /// Checking whether we can cast to an existential type
        let regexS: Regex<Substring> = Regex { "a" }
        XCTAssertNil(regexS as? Regex<AnyRegexOutput>)
        
        /// Demonstrate casting to a parameterized type
        func makeType<T>(_ t: T.Type, regex: Any) -> Regex<T>? {
            regex as? Regex<T>
        }
        
//        func makeCapturable<T>(_ t: Capturable, regex: Any) -> Regex<T>? {
//            makeType(type(of: t), regex: regex)
//        }
        
        /// Demonstrate returning mismatched types using `Any`
        func multipleReturn(_ condition: Bool) -> Any {
            if condition {
                return Regex { "a"; "b" }
            } else {
                return Regex { "a"; Capture { "b" } }
            }
        }
        
        let erased: Any = regexS
        
        XCTAssertNotNil(makeType(type(of: Date()), regex: erased))
    }
    
    /// Try to convert metatypes to optional metatypes
    func testMetatypes() throws {
//        func optionalizetMetatypes(_ arr: [Capturable.Type]) -> [Capturable.Type] {
//            var optArr: [Capturable.Type] = []
//            let t: Capturable.Type = arr[0]
//            let optT: Capturable.Type = Optional<type(of: "")>.self
//            return []
//        }
    }
    
    func testArity() throws {
        let eleven: Regex = Regex {
             "01"
             "02"
             "03"
             "04"
             "05"
             "06"
             "07"
             "08"
             "09"
             "10"
             "11"
        }
        
        let elevenCapture: Regex = Regex {
            Capture { "01" }
            Capture { "02" }
            Capture { "03" }
            Capture { "04" }
            Capture { "05" }
            Capture { "06" }
            Capture { "07" }
            Capture { "08" }
            Capture { "09" }
            Capture { "10" }
//            Capture { "11" }
        }
        
        let elevenNestCapture: Regex<(
            Substring, /// Whole capture
            Substring, /// 1
            Substring, /// 2
            Substring, /// 3
            Substring, /// 4
            Substring, /// 5
            Substring, /// 6
            Substring, /// 7
            Substring, /// 8
            Substring, /// 9
            Substring /// 10
//            Substring  /// 11
        )> = Regex {
            One(Regex {
                Capture { "01" }
                Capture { "02" }
                Capture { "03" }
                Capture { "04" }
                Capture { "05" }
            })
            One(Regex {
                Capture { "06" }
                Capture { "07" }
                Capture { "08" }
                Capture { "09" }
                Capture { "10" }
            })
//            Capture { "11" }
        }
        
        let wrap: One = One(elevenCapture)
    }
    
    
    func testMetatypeConstructor() throws {
        
    }
}

protocol Capturable { }
extension Date: Capturable { }
extension Substring: Capturable { }

enum CapturableType {
    case date
    case substring
    
    func metatype() -> Capturable.Type {
        switch self {
        case .date:
            return Date.self
        case .substring:
            return Substring.self
        }
    }
}

enum CaptureGroups {
    case c0
    case c1(Capturable)
    
//        func metatype<T>() -> T.Type {
//            switch self {
//            case .date:
//                return Date.self
//            case .substring:
//                return Substring.self
//            }
//        }
}
