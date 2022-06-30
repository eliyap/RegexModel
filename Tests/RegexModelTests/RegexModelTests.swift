import XCTest
@testable import RegexModel

final class RegexModelTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(RegexModel().text, "Hello, World!")
    }
    
    func testOneOrMore() throws {
        let pattern = ComponentModel.oneOrMore(.init(components: [
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
}
