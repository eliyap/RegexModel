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
////    public private(set) var proxy: ComponentModel.Proxy = .error
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
    public private(set) var proxy: ComponentModel.Proxy = .dateTime

    /// Example string: https://www.hackingwithswift.com/example-code/system/how-to-convert-dates-and-times-to-a-string-using-dateformatter
    public var dateStyle: DateStyling
    public var timeStyle: TimeStyling
    public var locale: Locale
    #warning("TODO: offer locale and timezone options")

    public init(dateStyle: DateStyling, timeStyle: TimeStyling, locale: Locale) {
        self.dateStyle = dateStyle
        self.timeStyle = timeStyle
        self.locale = locale
    }

    public static func createNew() -> DateTimeParameter {
        .init(dateStyle: .default, timeStyle: .default, locale: .autoupdatingCurrent)
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
                locale: locale,
                timeZone: .current
            )
        }
    }
}

#warning("ISO8601 omitted for now")
//public struct ISO8601DateTimeParameter {
//    public private(set) var id = UUID().uuidString
////    public private(set) var proxy: ComponentModel.Proxy = .error
//
//    public var includingFractionalSeconds: Bool
//    public var dateSeparator
//}

/// Omitted: Double, which I believe overlaps decimal?
/// Unsure, though https://fuckingformatstyle.com/#number-style

public struct CurrencyParameter: RegexParameter {
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .currency

    public var locale: Locale

    public init(locale: Locale) {
        self.locale = locale
    }

    public static func createNew() -> CurrencyParameter {
        .init(locale: .autoupdatingCurrent)
    }

    public func regex() -> Regex<Substring> {
        
        let currency: Locale.Currency
        if let localeCurrency = locale.currency {
            currency = localeCurrency
        } else {
            assert(false, "Currency unknown")
            currency = .unknown
        }
        return Regex {
            "" /// Tricks compiler into using `Substring`.
            One(.localizedCurrency(code: currency, locale: locale))
        }
    }
}

public struct DecimalParameter: RegexParameter {
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .decimal

    public var locale: Locale

    public init(locale: Locale) {
        self.locale = locale
    }

    public static func createNew() -> DecimalParameter {
        .init(locale: .autoupdatingCurrent)
    }

    public func regex() -> Regex<Substring> {
        
        return Regex {
            "" /// Tricks compiler into using `Substring`.
            One(.localizedDecimal(locale: locale))
        }
    }
}

/// - Note: name changed from "Integer" to be more approachable
public struct WholeNumberParameter: RegexParameter {
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .wholeNumber

    public var locale: Locale

    public init(locale: Locale) {
        self.locale = locale
    }

    public static func createNew() -> WholeNumberParameter {
        .init(locale: .autoupdatingCurrent)
    }

    public func regex() -> Regex<Substring> {
        
        return Regex {
            "" /// Tricks compiler into using `Substring`.
            One(.localizedInteger(locale: locale))
        }
    }
}

/// - Note: name changed to be consistent with `Decimal` above, and because `Double` is a CS term.
public struct DecimalPercentageParameter: RegexParameter {
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .decimalPercentage

    public var locale: Locale

    public init(locale: Locale) {
        self.locale = locale
    }

    public static func createNew() -> DecimalPercentageParameter {
        .init(locale: .autoupdatingCurrent)
    }

    public func regex() -> Regex<Substring> {
        
        return Regex {
            "" /// Tricks compiler into using `Substring`.
            One(.localizedDoublePercentage(locale: locale))
        }
    }
}

/// - Note: name changed from "Integer" to be more approachable
public struct WholeNumberPercentageParameter: RegexParameter {
    public private(set) var id = UUID().uuidString
    public private(set) var proxy: ComponentModel.Proxy = .wholeNumberPercentage

    public var locale: Locale

    public init(locale: Locale) {
        self.locale = locale
    }

    public static func createNew() -> WholeNumberPercentageParameter {
        .init(locale: .autoupdatingCurrent)
    }

    public func regex() -> Regex<Substring> {
        
        return Regex {
            "" /// Tricks compiler into using `Substring`.
            One(.localizedIntegerPercentage(locale: locale))
        }
    }
}
