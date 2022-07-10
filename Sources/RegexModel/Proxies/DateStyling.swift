//
//  DateStyling.swift
//  
//
//  Created by Secret Asian Man Dev on 10/7/22.
//

import Foundation

/// Database friendly proxy for strategies enumerated at
/// https://developer.apple.com/documentation/foundation/date/formatstyle/datestyle
public enum DateStyling: Int, Codable, Hashable, Sendable, CaseIterable {
    case abbreviated = 0
    case complete    = 1
    case long        = 2
    case numeric     = 3
    case omitted     = 4
    
    var style: Foundation.Date.FormatStyle.DateStyle {
        switch self {
        case .abbreviated:
            return .abbreviated
        case .complete:
            return .complete
        case .long:
            return .long
        case .numeric:
            return .numeric
        case .omitted:
            return .omitted
        }
    }
    
    var displayTitle: String {
        switch self {
        case .abbreviated:
            return "Abbreviated"
        case .complete:
            return "Complete"
        case .long:
            return "Long"
        case .numeric:
            return "Numeric"
        case .omitted:
            return "Omitted"
        }
    }
    
    /// Personal decision, seems to follow docs.
    static var `default`: Self = .numeric
}

public enum TimeStyling: Int, Codable, Hashable, CaseIterable {
    case complete  = 0
    case shortened = 1
    case standard  = 2
    case omitted   = 3
    
    var style: Foundation.Date.FormatStyle.TimeStyle {
        switch self {
        case .complete:
            return .complete
        case .shortened:
            return .shortened
        case .standard:
            return .standard
        case .omitted:
            return .omitted
        }
    }
    
    var displayTitle: String {
        switch self {
        case .complete:
            return "Complete"
        case .shortened:
            return "Shortened"
        case .standard:
            return "Standard"
        case .omitted:
            return "Omitted"
        }
    }
    
    /// Personal decision, seems to follow docs.
    static var `default`: Self = .shortened
}

