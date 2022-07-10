import XCTest
@testable import RegexModel

import RegexBuilder

final class RegexLabTests: XCTestCase {
    
    var pattern: Regex<Substring>! = nil
    
    func testARE() throws {
//        var regex: Regex<AnyRegexOutput> = Regex {
//            Capture {
//                "fish"
//            }
//        }
//
//        regex = Regex { }
//
//        let match = try regex.firstMatch(in: "dogfish")
//        let anyMatch = AnyRegexOutput(match!)
//        print(anyMatch.count)
    }
    
    func testMux() throws {
        var cond = true
        let regex = Regex {
            
        }
    }
    
    func testCRC() throws {
        print("")
        let _ = try Regex {
            NeverCRC()
        }.firstMatch(in: "string")
        
        print("")
        let _ = try Regex {
            CharCRC()
        }.firstMatch(in: "string")
        
        print("")
        let _ = try Regex {
            CharCRC()
            "g"
        }.firstMatch(in: "string")
        
        print("")
        let _ = try Regex {
            EverythingCRC()
            "ing"
        }.firstMatch(in: "string")
    }
    
    func testCurrency() throws {
        let usd = Regex {
            One(.localizedCurrency(code: .init("usd"), locale: Locale(identifier: "en-US")))
        }
        
        /// testing the limits of permissible currency expressions
        XCTAssertNotNil(try usd.wholeMatch(in: "$100"))
        
        XCTAssertNotNil(try usd.wholeMatch(in: "$1000.00"))
        XCTAssertNotNil(try usd.wholeMatch(in: "$1000."))
        
        XCTAssertNotNil(try usd.wholeMatch(in: "$1000000"))
        XCTAssertNotNil(try usd.wholeMatch(in: "$1,000,000.00"))
        XCTAssertNotNil(try usd.wholeMatch(in: "$1 000 000.00"))
        XCTAssertNotNil(try usd.wholeMatch(in: "$1 000 000"))
        XCTAssertNotNil(try usd.wholeMatch(in: "$1000.0000000000000000"))
        
        XCTAssertNil(try usd.wholeMatch(in: "$10,00"))
        XCTAssertNil(try usd.wholeMatch(in: "$1,0,0,0"))
        
        XCTAssertNil(try usd.wholeMatch(in: "US$1"))
        XCTAssertNil(try usd.wholeMatch(in: "$perl"))
        
        XCTAssertNotNil(try usd.firstMatch(in: "US$1"))
        
        
    }
    
    func testLocale() throws {
        let badLocale = Locale(identifier: "invalid nonsense bad string ⚠️")
        print(badLocale, badLocale.currency, badLocale.timeZone)
    }
}

struct NeverCRC: CustomConsumingRegexComponent {
    
    typealias RegexOutput = Substring
    
    let id: String = UUID().uuidString
    
    func consuming(_ input: String, startingAt index: String.Index, in bounds: Range<String.Index>) throws -> (upperBound: String.Index, output: Substring)? {
        let lowerBound = input.distance(from: input.startIndex, to: bounds.lowerBound)
        let upperBound = input.distance(from: input.startIndex, to: bounds.upperBound)
        let intRange: Range<Int> = lowerBound..<upperBound
        
        print("Range", intRange, id)
        
        return nil
    }
}

struct CharCRC: CustomConsumingRegexComponent {
    
    typealias RegexOutput = Substring
    
    let id: String = UUID().uuidString
    
    func consuming(_ input: String, startingAt index: String.Index, in bounds: Range<String.Index>) throws -> (upperBound: String.Index, output: Substring)? {
        let lowerBound = input.distance(from: input.startIndex, to: bounds.lowerBound)
        let upperBound = input.distance(from: input.startIndex, to: bounds.upperBound)
        let intRange: Range<Int> = lowerBound..<upperBound
        
        print("Range", intRange, id)
        
        guard index != input.endIndex, index < bounds.upperBound else {
            print("empty")
            return nil
        }
        let oneUp = input.index(after: index)
        return (oneUp, input[index..<oneUp])
    }
}

struct EverythingCRC: CustomConsumingRegexComponent {
    
    typealias RegexOutput = Substring
    
    let id: String = UUID().uuidString
    
    func consuming(_ input: String, startingAt index: String.Index, in bounds: Range<String.Index>) throws -> (upperBound: String.Index, output: Substring)? {
        let lowerBound = input.distance(from: input.startIndex, to: bounds.lowerBound)
        let upperBound = input.distance(from: input.startIndex, to: bounds.upperBound)
        let intRange: Range<Int> = lowerBound..<upperBound
        
        print("Range", intRange, id)
        
        let asFarAsPossible = min(input.endIndex, bounds.upperBound)
        
        return (asFarAsPossible, input[index..<asFarAsPossible])
    }
}
