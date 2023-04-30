//
//  ColorSet.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 30/04/2023.
//

import UIKit

protocol PColorSet: RColorSet {
    var lightGray: String { get }
}

class ColorSet: RColorSet, PColorSet {
    var lightGray: String = "lightGray"
}
