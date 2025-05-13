//
//  ItunesDateFormatter.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 07/05/2025.
//
import Foundation

extension DateFormatter {
    func itunesDateForDisplayString(_ dateString: String) -> String? {
        self.dateFormat = "yyyy-mm-dd'T'HH:mm:ssZ"
        return date(from: dateString)?.formatted(date: .long, time: .omitted)
    }
    
    func dateToItunesAPIString(_ date: Date) -> String {
        self.dateFormat = "yyyy-mm-dd'T'HH:mm:ssZ"
        return string(from: date)
    }
    
    func dateFromItunesAPIString(_ dateString: String) -> Date? {
        self.dateFormat = "yyyy-mm-dd'T'HH:mm:ssZ"
        return date(from: dateString)
    }
}
