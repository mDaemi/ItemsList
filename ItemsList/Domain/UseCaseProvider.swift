//
//  UseCaseProvider.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 01/05/2023.
//

import Foundation

protocol UseCaseProvider {
    func provideAppUseCase() -> AppUseCase
}
