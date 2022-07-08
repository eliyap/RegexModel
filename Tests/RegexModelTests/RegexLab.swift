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
