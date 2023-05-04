//
//  FontConstant.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 04/05/2023.
//

import UIKit

public enum FontConstant: String {
    case boldBig = "boldBig"
    case boldMedium = "boldMedium"
    case boldNormal = "boldNormal"
    case mediumBig = "mediumBig"
    case mediumNormal = "mediumNormal"
    case mediumSuperTiny = "mediumSuperTiny"
    case regularMedium = "regularMedium"
    case regularNormal = "regularNormal"
    case regularSmall = "regularSmall"
    case regularTiny = "regularTiny"

    public func getFont() -> UIFont {
        var font: UIFont = UIFont.systemFont(ofSize: 14)
      switch self {
      case .boldBig:
        font = UIFont.boldSystemFont(ofSize: 20)
      case .boldMedium:
        font = UIFont.boldSystemFont(ofSize: 16)
      case .boldNormal:
        font = UIFont.boldSystemFont(ofSize: 12)
      case .mediumBig:
        font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium)
      case .mediumNormal:
        font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium)
      case .mediumSuperTiny:
        font = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.medium)
      case .regularMedium:
        font = UIFont.systemFont(ofSize: 18)
      case .regularNormal:
        font = UIFont.systemFont(ofSize: 16)
      case .regularSmall:
        font = UIFont.systemFont(ofSize: 14)
      case .regularTiny:
        font = UIFont.systemFont(ofSize: 11)
      }
      return font
    }
}
