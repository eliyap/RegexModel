//
//  File.swift
//  
//
//  Created by Secret Asian Man Dev on 10/7/22.
//

import Foundation
import RegexBuilder

#warning("Cannot use dynamic string date format")
//public struct FormattedDateParameter {
//    public private(set) var id = UUID().uuidString
////    public private(set) var proxy: ComponentModel.Proxy = .string
//
//    /// Example string: https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
//    public var format: String = ""
//
//    public init() {
//    }
//
//    public static func createNew() -> FormattedDateParameter {
//        .init()
//    }
//
//    public func regex() -> Regex<Substring> {
//        Regex {
//            "" /// Tricks compiler into using `Substring`.
//
//            /// https://developer.apple.com/documentation/swift/regexcomponent/date(_:locale:timezone:calendar:)
//            Date.ParseStrategy.date(
//                format: .init(stringInterpolation: "\(format)"),
//                locale: .current,
//                timeZone: .current,
//                calendar: .current,
//                referenceDate: .now
//            )
//        }
//    }
//}

public struct DateTimeParameter: RegexParameter {
    public private(set) var id = UUID().uuidString
//    public private(set) var proxy: ComponentModel.Proxy = .string

    /// Example string: https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
    public var dateStyle: DateStyling
    public var timeStyle: TimeStyling
    #warning("TODO: offer locale and timezone options")

    public init(dateStyle: DateStyling, timeStyle: TimeStyling) {
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
    }

    public static func createNew() -> DateTimeParameter {
        .init(dateStyle: .default, timeStyle: .default)
    }

    public func regex() -> Regex<Substring> {
        /// Docs explicitly warn that omitting both is invalid, catch this state.
        guard dateStyle != .omitted || timeStyle != .omitted else {
            return Regex { }
        }
        
        return Regex {
            "" /// Tricks compiler into using `Substring`.

            /// https://developer.apple.com/documentation/swift/regexcomponent/date(_:locale:timezone:calendar:)
            Date.ParseStrategy.dateTime(
                date: dateStyle.style,
                time: timeStyle.style,
                locale: .current,
                timeZone: .current
            )
        }
    }
}

#warning("ISO8601 omitted for now")
//public struct ISO8601DateTimeParameter {
//    public private(set) var id = UUID().uuidString
////    public private(set) var proxy: ComponentModel.Proxy = .string
//
//    public var includingFractionalSeconds: Bool
//    public var dateSeparator
//}

// MARK: - Locale Parsers
/// Omitted: Double, which I believe overlaps decimal?
/// Unsure, though https://fuckingformatstyle.com/#number-style

public struct CurrencyParameter {
    public private(set) var id = UUID().uuidString
//    public private(set) var proxy: ComponentModel.Proxy = .string

    public var locale: Locale

    public init(locale: Locale) {
        self.locale = locale
    }

    public static func createNew() -> CurrencyParameter {
        .init(locale: .autoupdatingCurrent)
    }

    public func regex() throws -> Regex<Substring> {
        
        guard let currency = locale.currency else {
            assert(false, "Currency unknown")
            throw LocaleError.noCurrencyForLocale
        }
        return Regex {
            "" /// Tricks compiler into using `Substring`.
            One(.localizedCurrency(code: currency, locale: locale))
        }
    }
}

public struct DecimalParameter {
    public private(set) var id = UUID().uuidString
//    public private(set) var proxy: ComponentModel.Proxy = .string

    public var locale: Locale

    public init(locale: Locale) {
        self.locale = locale
    }

    public static func createNew() -> DecimalParameter {
        .init(locale: .autoupdatingCurrent)
    }

    public func regex() throws -> Regex<Substring> {
        
        return Regex {
            "" /// Tricks compiler into using `Substring`.
            One(.localizedDecimal(locale: locale))
        }
    }
}

/// - Note: name changed from "Integer" to be more approachable
public struct WholeNumberParameter: RegexParameter {
    public private(set) var id = UUID().uuidString
//    public private(set) var proxy: ComponentModel.Proxy = .string

    public var locale: Locale

    public init(locale: Locale) {
        self.locale = locale
    }

    public static func createNew() -> DecimalParameter {
        .init(locale: .autoupdatingCurrent)
    }

    public func regex() throws -> Regex<Substring> {
        
        return Regex {
            "" /// Tricks compiler into using `Substring`.
            One(.localizedInteger(locale: locale))
        }
    }
}

/// - Note: name changed to be consistent with `Decimal` above, and because `Double` is a CS term.
public struct DecimalPercentageParameter {
    public private(set) var id = UUID().uuidString
//    public private(set) var proxy: ComponentModel.Proxy = .string

    public var locale: Locale

    public init(locale: Locale) {
        self.locale = locale
    }

    public static func createNew() -> DecimalParameter {
        .init(locale: .autoupdatingCurrent)
    }

    public func regex() throws -> Regex<Substring> {
        
        return Regex {
            "" /// Tricks compiler into using `Substring`.
            One(.localizedDoublePercentage(locale: locale))
        }
    }
}

/// - Note: name changed from "Integer" to be more approachable
public struct WholeNumberPercentageParameter {
    public private(set) var id = UUID().uuidString
//    public private(set) var proxy: ComponentModel.Proxy = .string

    public var locale: Locale

    public init(locale: Locale) {
        self.locale = locale
    }

    public static func createNew() -> DecimalParameter {
        .init(locale: .autoupdatingCurrent)
    }

    public func regex() throws -> Regex<Substring> {
        
        return Regex {
            "" /// Tricks compiler into using `Substring`.
            One(.localizedIntegerPercentage(locale: locale))
        }
    }
}
