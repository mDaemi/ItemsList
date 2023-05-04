//
//  ColorSet.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import UIKit

protocol PColorSet: RColorSet {
    var lightGray: String { get }
    var lightRed: String { get }
    var softBlack: String { get }
}

class ColorSet: RColorSet, PColorSet {
    var lightGray: String = "lightGray"
    var lightRed: String = "lightRed"
    var softBlack: String = "softBlack"
}
