//
//  Locale.swift
//  
//
//  Created by Secret Asian Man Dev on 10/7/22.
//

import Foundation

public enum LocaleError: Error {
    /// Thrown when `Locale.currency` is `nil`.
    case noCurrencyForLocale
}

#warning("TODO, offer a set of common locales to use")
// e.g. USA, EU, JP, CN. etc.
// or better, just generate locales from apple's list and filter for those with currencies
