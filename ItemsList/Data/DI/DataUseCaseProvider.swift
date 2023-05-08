//
//  DataUseCaseProvider.swift
//  ItemsList
//
//  Created by Maedeh DAEMI on 04/05/2023.
//

import Foundation

class DataUseCaseProvider: UseCaseProvider {
    func provideAppUseCase() -> PAppUseCase {
        return AppUseCase(repository: AppRepository.shared)
    }
}
