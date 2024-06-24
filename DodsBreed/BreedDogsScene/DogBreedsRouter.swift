//
//  DogBreedsRouter.swift
//
//  Created by Татьяна Исаева on 13.10.2022.
//

import Foundation

protocol DogBreedsNavigationLogic {
    func pushDogBreedsDetailsModule(withId DogBreedsId: UniqueIdentifier)
}

final class DogBreedsRouter {
	weak var viewController: DogBreedsViewController?
}

// MARK: - Business Logic

extension DogBreedsRouter: DogBreedsNavigationLogic {
    func pushDogBreedsDetailsModule(withId DogBreedsId: UniqueIdentifier) {
        let detailsController = DogBreedsDetailsBuilder()
            .set(initialState: .initial(id: DogBreedsId))
            .build()
        viewController?.navigationController?.pushViewController(detailsController, animated: true)
    }
}
