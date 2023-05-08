//
//  File.swift
//  ItemsListTests
//
//  Created by Maedeh DAEMI on 08/05/2023.
//

import Foundation
@testable import ItemsList

class DataUseCaseProviderMock: UseCaseProvider {
    public func provideAppUseCase() -> AppUseCase {
        return AppUseCase(repository: AppRepository.shared)
    }
    
    public func provideAppUseCaseMock() -> AppUseCaseMock {
        return AppUseCaseMock(repository: AppRepository.shared)
    }
}
