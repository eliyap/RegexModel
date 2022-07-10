//
//  Locale.swift
//  
//
//  Created by Secret Asian Man Dev on 10/7/22.
//

import Foundation
import SwiftUI

#warning("TODO, offer a set of common locales to use")
// e.g. USA, EU, JP, CN. etc.
// or better, just generate locales from apple's list and filter for those with currencies

/// Courtesy the Amplosion Guy
/// https://gist.githubusercontent.com/christianselig/09383de004bd878ba4a86663bc6d1b0b/raw/c7c515f936800e2e09e04c75ccbd3ee13839b4f0/Locale+SFSymbol.swift
public extension Locale {
    /// Returns an SF Symbol currency image that match's the device's current locale, for instance dollar in North America, Indian rupee in India, etc.
    var currencySFSymbol: Image {
        Image(systemName: currencySymbolNameForSFSymbols()
             /// Default currency symbol will be the Animal Crossing Leaf coin 􁂬 to remain impartial to any specific country
             ?? "leaf.circle")
    }
    
    private func currencySymbolNameForSFSymbols() -> String? {
        guard let currencySymbol = currencySymbol else { return nil }
        
        let symbols: [String: String] = [
            "$": "dollar",
            "¢": "cent",
            "¥": "yen",
            "£": "sterling",
            "₣": "franc",
            "ƒ": "florin",
            "₺": "turkishlira",
            "₽": "ruble",
            "€": "euro",
            "₫": "dong",
            "₹": "indianrupee",
            "₸": "tenge",
            "₧": "peseta",
            "₱": "peso",
            "₭": "kip",
            "₩": "won",
            "₤": "lira",
            "₳": "austral",
            "₴": "hryvnia",
            "₦": "naira",
            "₲": "guarani",
            "₡": "coloncurrency",
            "₵": "cedi",
            "₢": "cruzeiro",
            "₮": "tugrik",
            "₥": "mill",
            "₪": "shekel",
            "₼": "manat",
            "₨": "rupee",
            "฿": "baht",
            "₾": "lari",
            "R$":" brazilianreal"
        ]
        
        guard let currencySymbolName = symbols[currencySymbol] else { return nil }
        return "\(currencySymbolName)sign"
    }
}
