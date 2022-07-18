//
//  CharacterKind.swift
//  
//
//  Created by Secret Asian Man Dev on 18/7/22.
//

import Foundation
import RegexBuilder

public enum CharacterKind: Codable, Sendable, Hashable {
    
    case unicode(CommonUnicode)
    case common(CommonClass)
    
    var characterClass: CharacterClass {
        switch self {
        case .unicode(let commonUnicode):
            return CharacterClass.generalCategory(commonUnicode.category)
        case .common(let common):
            return common.characterClass
        }
    }
    
    public static let `default`: CharacterKind = .common(.any)
    
    public var displayTitle: String {
        switch self {
        case .unicode(let commonUnicode):
            return commonUnicode.displayTitle
        case .common(let commonClass):
            return commonClass.displayTitle
        }
    }
}

extension CharacterKind: CaseIterable {
    /// Non-unicode should come first, unicode is more obscure
    public static var allCases: [CharacterKind] = CommonClass.allCases.map { cls in return .common(cls) } + CommonUnicode.allCases.map { unicode in return .unicode(unicode) }
}

/// Source: https://developer.apple.com/documentation/regexbuilder/characterclass/regexcomponent-implementations
public enum CommonClass: Int, Codable, Sendable, Hashable, RawRepresentable, CaseIterable {
    case any                  = 0
    case anyGrapheme          = 1
    case anyUnicodeScalar     = 2
    case digit                = 3
    case hexDigit             = 4
    // case horizontalWhitespace = 5
    case newlineSequence      = 6
    // case verticalWhitespace   = 7
    case whitespace           = 8
    case word                 = 9
    
    var characterClass: CharacterClass {
        switch self {
        case .any:
            return .any
        case .anyGrapheme:
            return .any
        case .anyUnicodeScalar:
            return .any
        case .digit:
            return .digit
        case .hexDigit:
            return .hexDigit
        case .newlineSequence:
            return .newlineSequence
        case .whitespace:
            return .whitespace
        case .word:
            return .word
        }
    }

    public static let `default`: CommonClass = .any

    public var displayTitle: String {
        switch self {
        case .any:
            return "Any"
        case .anyGrapheme:
            return "Any Grapheme"
        case .anyUnicodeScalar:
            return "Any Unicode Scalar"
        case .digit:
            return "Digit"
        case .hexDigit:
            return "Hex Digit"
        case .newlineSequence:
            return "Newline"
        case .whitespace:
            return "Whitespace"
        case .word:
            return "Word"
        }
    }
}

/// Referenced from https://developer.apple.com/documentation/swift/unicode/generalcategory
/// Might need to revise later.
///
/// Selected only the anticipated common needs, commenting out the others.
public enum CommonUnicode: Int, Codable, Sendable, Hashable, RawRepresentable, CaseIterable {
    /// A closing punctuation mark of a pair.
//    case closePunctuation = 0

    /// A connecting punctuation mark, like a tie.
//    case connectorPunctuation = 1

    /// A C0 or C1 control code.
//    case control = 2

    /// A currency sign.
    case currencySymbol = 3

    /// A dash or hyphen punctuation mark.
    case dashPunctuation = 4

    /// A decimal digit.
    /// - Note: Includes characters many users may not expect https://www.fileformat.info/info/unicode/category/Nd/list.htm
//    case decimalNumber = 5

    /// An enclosing combining mark.
//    case enclosingMark = 6

    /// A final quotation mark.
//    case finalPunctuation = 7

    /// A format control character.
//    case format = 8

    /// An initial quotation mark.
//    case initialPunctuation = 9

    /// A letter-like numeric character.
//    case letterNumber = 10

    /// A line separator, which is specifically (and only) U+2028 LINE SEPARATOR.
//    case lineSeparator = 11

    /// A lowercase letter.
    case lowercaseLetter = 12

    /// A symbol of mathematical use.
    case mathSymbol = 13

    /// A modifier letter.
//    case modifierLetter = 14

    /// A non-letterlike modifier symbol.
//    case modifierSymbol = 15

    /// A non-spacing combining mark with zero advance width (abbreviated Mn).
//    case nonspacingMark = 16

    /// An opening punctuation mark of a pair.
//    case openPunctuation = 17

    /// Other letters, including syllables and ideographs.
//    case otherLetter = 18

    /// A numeric character of another type.
//    case otherNumber = 19

    /// A punctuation mark of another type.
//    case otherPunctuation = 20

    /// A symbol of another type.
//    case otherSymbol = 21

    /// A paragraph separator, which is specifically (and only) U+2029 PARAGRAPH SEPARATOR.
//    case paragraphSeparator = 22

    /// A private-use character.
//    case privateUse = 23

    /// A space character of non-zero width.
    case spaceSeparator = 24

    /// A spacing combining mark with positive advance width.
//    case spacingMark = 25

    /// A surrogate code point.
//    case surrogate = 26

    /// A digraph character whose first part is uppercase.
//    case titlecaseLetter = 27

    /// A reserved unassigned code point or a non-character.
//    case unassigned = 28

    /// An uppercase letter. 
    case uppercaseLetter = 29
}

public extension CommonUnicode {
    var category: Unicode.GeneralCategory {
        switch self {
//        case .closePunctuation:
//            return .closePunctuation
//        case .connectorPunctuation:
//            return .connectorPunctuation
//        case .control:
//            return .control
        case .currencySymbol:
            return .currencySymbol
        case .dashPunctuation:
            return .dashPunctuation
//        case .decimalNumber:
//            return .decimalNumber
//        case .enclosingMark:
//            return .enclosingMark
//        case .finalPunctuation:
//            return .finalPunctuation
//        case .format:
//            return .format
//        case .initialPunctuation:
//            return .initialPunctuation
//        case .letterNumber:
//            return .letterNumber
//        case .lineSeparator:
//            return .lineSeparator
        case .lowercaseLetter:
            return .lowercaseLetter
        case .mathSymbol:
            return .mathSymbol
//        case .modifierLetter:
//            return .modifierLetter
//        case .modifierSymbol:
//            return .modifierSymbol
//        case .nonspacingMark:
//            return .nonspacingMark
//        case .openPunctuation:
//            return .openPunctuation
//        case .otherLetter:
//            return .otherLetter
//        case .otherNumber:
//            return .otherNumber
//        case .otherPunctuation:
//            return .otherPunctuation
//        case .otherSymbol:
//            return .otherSymbol
//        case .paragraphSeparator:
//            return .paragraphSeparator
//        case .privateUse:
//            return .privateUse
        case .spaceSeparator:
            return .spaceSeparator
//        case .spacingMark:
//            return .spacingMark
//        case .surrogate:
//            return .surrogate
//        case .titlecaseLetter:
//            return .titlecaseLetter
//        case .unassigned:
//            return .unassigned
        case .uppercaseLetter:
            return .uppercaseLetter
        }
    }
    
    var displayTitle: String {
        switch self {
        case .currencySymbol:
            return "Currency Symbol"
        case .dashPunctuation:
            return "Dash Punctuation"
        case .lowercaseLetter:
            return "Lowercase Letter"
        case .mathSymbol:
            return "Math Symbol"
        case .spaceSeparator:
            /// - Note: differentiate from `.whitespace`
            return "Unicode Space Separator"
        case .uppercaseLetter:
            return "Uppercase Letter"
        }
    }
}
