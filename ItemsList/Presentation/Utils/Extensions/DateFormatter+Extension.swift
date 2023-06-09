//
//  DateFormatter+Extension.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import Foundation

extension DateFormatter {
    static let europeanFormat: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "dd/MM/YY"
      formatter.calendar = Calendar(identifier: .iso8601)
      formatter.timeZone = TimeZone(secondsFromGMT: 0)
      formatter.locale = Locale(identifier: "en_US_POSIX")
      return formatter
    }()
}
