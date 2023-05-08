//
//  UseCaseProvider.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import Foundation
import UIKit

protocol UseCaseProvider {
    func provideAppUseCase() -> PAppUseCase
}
