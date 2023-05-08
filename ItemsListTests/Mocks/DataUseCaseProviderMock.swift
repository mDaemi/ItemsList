//
//  File.swift
//  ItemsListTests
//
//  Created by Maedeh DAEMI on 08/05/2023.
//

import Foundation
@testable import ItemsList

class DataUseCaseProviderMock: UseCaseProvider {
    func provideAppUseCase() -> PAppUseCase {
        return AppUseCaseMock(repository: AppRepository.shared)
    }
}
