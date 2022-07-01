import XCTest
@testable import RegexModel

final class RegexModelTests: XCTestCase {
    
    var pattern: Regex<Substring>! = nil
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RegexModel().text, "Hello, World!")
    }
    
    func testOneOrMore() throws {
        pattern = ComponentModel.oneOrMore(.init(components: [
            .string(.init(string: "cat")),
        ])).regex()
        
        XCTAssertNotNil(try pattern.wholeMatch(in: "cat"))
        XCTAssertNotNil(try pattern.wholeMatch(in: "catcat"))
        XCTAssertNotNil(try pattern.wholeMatch(in: "catcatcat"))
        
        /// Wrong string.
        XCTAssertNil(try pattern.wholeMatch(in: "dog"))
        
        /// Zero matches.
        XCTAssertNil(try pattern.wholeMatch(in: ""))
    }
    
    func testChoiceOf() throws {
        pattern = ComponentModel.choiceOf(.init(components: [
            .string(.init(string: "cat")),
            .string(.init(string: "dog")),
            .string(.init(string: "fish")),
        ])).regex()
        
        XCTAssertNotNil(try pattern.wholeMatch(in: "cat"))
        XCTAssertNotNil(try pattern.wholeMatch(in: "dog"))
        XCTAssertNotNil(try pattern.wholeMatch(in: "fish"))
        
        /// Ensures we did NOT use concatenation.
        XCTAssertNil(try pattern.wholeMatch(in: "catdogfish"))
        
        pattern = ComponentModel.oneOrMore(.init(components: [
            .choiceOf(.init(components: [
                .string(.init(string: "cat")),
                .string(.init(string: "dog")),
                .string(.init(string: "fish")),
            ]))
        ])).regex()
        
        XCTAssertNotNil(try pattern.wholeMatch(in: "catdogfish"))
        XCTAssertNotNil(try pattern.wholeMatch(in: "dogcatfish"))
        XCTAssertNotNil(try pattern.wholeMatch(in: "fishdogcat"))
    }
    
    func testAnchor() throws {
        pattern = [
            .anchor(.init(boundary: .wordBoundary)),
            .string(.init(string: "dog")),
            .anchor(.init(boundary: .wordBoundary)),
        ].regex()
        
        XCTAssertNotNil(try pattern.firstMatch(in: "dog food"))
        XCTAssertNotNil(try pattern.firstMatch(in: "my dog"))
        XCTAssertNotNil(try pattern.firstMatch(in: "my dog food"))
        
        /// Punctuation is a word boundary
        XCTAssertNotNil(try pattern.firstMatch(in: "up-dog"))
        
        XCTAssertNil(try pattern.firstMatch(in: "doghouse"))
        XCTAssertNil(try pattern.firstMatch(in: "hotdog"))
    }
}
