//
//  DogBreedsInteractor.swift
//
//  Created by Татьяна Исаева on 04.09.2022.
//
import Foundation

protocol DogBreedsBusinessLogic {
    func fetchItems(request: DogBreeds.DogBreedsList.Request)
}

final class DogBreedsInteractor {
     let presenter: DogBreedsPresentationLogic
     let provider: DogBreedsProviderProtocol

    // MARK: - Init

    init(presenter: DogBreedsPresentationLogic, provider: DogBreedsProviderProtocol = DogBreedsProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
}

// MARK: - Business Logic

extension DogBreedsInteractor: DogBreedsBusinessLogic {
    func fetchItems(request: DogBreeds.DogBreedsList.Request) {
        provider.getItems { (items, error) in
            let result: Result<[DogBreedsModel]>
            if let items = items {
                if request.isFavorite {
					let favorites = UserDefaults.standard.getFeaturedBreeds() ?? []
					result = .success(items.filter { favorites.contains($0.uid) })
                } else {
                    result = .success(items)
                }
            } else if let error = error {
                result = .failure(error.associatedValue)
            } else {
                result = .failure(DogBreeds.DogBreedsList.Response.Error.someError)
            }
            self.presenter.presentItems(response: .init(result: result))
        }
    }
}

