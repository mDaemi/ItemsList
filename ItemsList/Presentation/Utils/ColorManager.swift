//
//  ColorManager.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import UIKit

class RColorSet: NSObject {

    func colors() -> [String: String] {
        var colors = [String: String]()
        let children = Mirror(reflecting: self).children
        for child in children {
            if let id = child.label, let value = (child.value as? String) {
                colors[id] = value
            }
        }
        return colors
    }
}

class ColorManager: NSObject {

    var colorSet: PColorSet

    static let shared: ColorManager = ColorManager()

    private override init() {
        colorSet = ColorSet()
    }

    func color (_ id: String) -> UIColor {
        let retrievedColor: [String: String] = self.colorSet.colors()
        var color = UIColor.white
        if let colorIdentifier = retrievedColor[id] {
            color = UIColor(named: colorIdentifier) ?? UIColor.white
        }
        return color
    }
}

