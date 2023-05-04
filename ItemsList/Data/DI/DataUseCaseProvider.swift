//
//  DataUseCaseProvider.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 04/05/2023.
//

import Foundation

class DataUseCaseProvider: UseCaseProvider {
    func provideAppUseCase() -> AppUseCase {
        return AppUseCase(repository: AppRepository.shared)
    }
}
