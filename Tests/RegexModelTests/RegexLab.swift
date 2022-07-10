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
    
    func testCharClasses() throws {
        /// all character classes listed as of 22.07.09
        /// https://developer.apple.com/documentation/swift/regexcomponent/any
        let _: [CharacterClass] = [
            CharacterClass.any,
            CharacterClass.anyGrapheme,
            CharacterClass.anyUnicodeScalar,

            CharacterClass.digit,
            CharacterClass.hexDigit,
            CharacterClass.word,

            CharacterClass.whitespace,
            CharacterClass.horizontalWhitespace,
            CharacterClass.verticalWhitespace,
            CharacterClass.newlineSequence,

            CharacterClass.anyOf(Array<Character>(arrayLiteral: "a", "b", "c")),
            CharacterClass.anyOf(Array<UnicodeScalar>(arrayLiteral: "a", "b", "c")),
        ]
    }
    
    func testParser() throws {
        /// WWDC Parsers:
        /// https://developer.apple.com/videos/play/wwdc2022/110357/?time=436
        /// https://developer.apple.com/videos/play/wwdc2022/110357/?time=515
        /// https://developer.apple.com/videos/play/wwdc2022/110357/?time=687
        
        /// parsers found as of 22.07.09
        /// from here onwards: https://developer.apple.com/documentation/swift/regexcomponent/date(_:locale:timezone:calendar:)
        
        /// paramters given straw values to demonstrate possible user points
        var lol: [any RegexComponent] = [
            Date.ParseStrategy.date(
                format: "",
                locale: .current,
                timeZone: .current,
                calendar: .current,
                referenceDate: .now
            ),
            Date.ParseStrategy.dateTime(
                date: .complete,
                time: .complete,
                locale: .current,
                timeZone: .current,
                calendar: .current
            ),
            Date.ISO8601FormatStyle.iso8601(
                timeZone: .current,
                includingFractionalSeconds: false,
                dateSeparator: .dash,
                dateTimeSeparator: .standard,
                timeSeparator: .colon
            ),
            Date.ISO8601FormatStyle.iso8601Date(
                timeZone: .current,
                dateSeparator: .dash
            ),
            Date.ISO8601FormatStyle.iso8601WithTimeZone(
                includingFractionalSeconds: false,
                dateSeparator: .dash,
                dateTimeSeparator: .space,
                timeSeparator: .colon,
                timeZoneSeparator: .colon
            ),
        ]
        
        #warning("TODO: add some tests validating that common currencies are valid inputs")
        /// dollar, euro and pound should cover most users
        /// add rupee, yuan, yen, ruble, swiss franc, etc.
        /// also check if USD, US$, SGD,  S$, etc. are valid???
        lol += [
            Decimal.FormatStyle.Currency.localizedCurrency(
                code: .init(stringLiteral: "$"),
                locale: .current
            ),
            IntegerFormatStyle<Int>.Currency.localizedIntegerCurrency(
                code: .init(stringLiteral: "$"),
                locale: .current
            ),
        ]
        
        lol += [
            Decimal.FormatStyle.localizedDecimal(locale: .current),
            FloatingPointFormatStyle<Double>.localizedDouble(locale: .current),
            IntegerFormatStyle<Int>.localizedInteger(locale: .current),
            
            FloatingPointFormatStyle<Double>.Percent.localizedDoublePercentage(locale: .current),
            IntegerFormatStyle<Int>.Percent.localizedIntegerPercentage(locale: .current),
        ]
        
        lol += [
            URL.ParseStrategy.url(
                scheme: .required,
                user: .required,
                password: .required,
                host: .required,
                port: .required,
                path: .required,
                query: .required,
                fragment: .required
            ),
        ]
    }
    
    /// checking out weirdness with type signature of foundation parsers
    func testCaptureSignature() throws {
        /// singleton will NOT compile with substring, only with date!
        let _: Regex<Date> = Regex {
            One(.date(.numeric, locale: .current, timeZone: .current))
        }
        
        /// but any series, including a pair of same type, reverts to substring
        let _: Regex<Substring> = Regex {
            One(.date(.numeric, locale: .current, timeZone: .current))
            One(.date(.numeric, locale: .current, timeZone: .current))
        }
        
        /// hacky way to "convert" the type
        let _: Regex<Substring> = Regex {
            "" /// won't compile without this!
            One(.date(.numeric, locale: .current, timeZone: .current))
        }
        
        /// note that capture is not implicit, we must explicitly capture, creating a tuple type
        let _: Regex<(Substring, Date)> = Regex {
            Capture {
                One(.date(.numeric, locale: .current, timeZone: .current))
            }
        }
    }
    
    /// check the types returned by foundation parsers
    func testParserTypes() throws {
        /// datetime is `Date`, which includes time info
        let _: Regex<Date> = Regex {
            One(.dateTime(
                date: .complete,
                time: .complete,
                locale: .current,
                timeZone: .current,
                calendar: .current
            ))
        }
        
        let _: Regex<Decimal> = Regex {
            One(.localizedCurrency(
                code: .init(stringLiteral: "$"),
                locale: .current
            ))
        }
        
        let _: Regex<Int> = Regex {
            One(.localizedIntegerCurrency(
                code: .init(stringLiteral: "$"),
                locale: .current
            ))
        }
        
        let _: Regex<Decimal> = Regex {
            One(.localizedDecimal(locale: .current))
        }
        
        let _: Regex<Int> = Regex {
            One(.localizedInteger(locale: .current))
        }
        
        let _: Regex<Double> = Regex {
            One(.localizedDouble(locale: .current))
        }
        
        let _: Regex<Double> = Regex {
            One(.localizedDoublePercentage(locale: .current))
        }
        
        let _: Regex<Int> = Regex {
            One(.localizedIntegerPercentage(locale: .current))
        }
        
        let _: Regex<URL> = Regex {
            One(.url())
        }
    }
    
    func testCaptureQuantifiers() throws {
        let _: Regex<(Substring, Substring?)> = Regex {
            ZeroOrMore {
                 Capture {
                    "a"
                }
            }
        }
        
        let _: Regex<(Substring, Substring?)> = Regex {
            Optionally {
                Capture {
                    "a"
                }
            }
        }
        
        let _: Regex<(Substring, Substring)> = Regex {
            OneOrMore {
                Capture {
                    "a"
                }
            }
        }
        
        /// Inconsistent with pitch at https://github.com/apple/swift-experimental-string-processing/blob/69d23a8a7fe8929a99cdcd76ecaa845a1330274e/Documentation/Evolution/StronglyTypedCaptures.md
        /// Should be `[Substring]`
        let _: Regex<(Substring, Substring?)> = Regex {
            Repeat(count: 3) {
                Capture {
                    "a"
                }
            }
        }
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
