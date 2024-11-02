//
//  MockNetworkingManager.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/29/24.
//

import XCTest
@testable import FetchTakeHome

/// Used by our View Model in our testing to hit local data
class MockNetworkingManager: RecipeNetworkingProtocol {
    private let resourceTitle: ResourcesTitle

    init(resourceTitle: ResourcesTitle) {
        self.resourceTitle = resourceTitle
    }

    func fetchRecipes() async throws -> RecipeResponse {
        if let path = Bundle(for: type(of: self)).path(forResource: "\(resourceTitle.rawValue)", ofType: "json") {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            return try jsonDecoder.decode(RecipeResponse.self, from: data)
        } else {
            return RecipeResponse(recipes: [])
        }
    }
}
