//
//  RecipeNetworkingManager.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/29/24.
//

import Foundation

struct RecipeNetworkingManager: RecipeNetworkingProtocol {
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    private let apiKey: APIURL

    init(apiKey: APIURL = .validRecipes) {
        self.apiKey = apiKey
    }

    func fetchRecipes() async throws -> RecipeResponse {
        guard let url = URL(string: apiKey.rawValue) else {
            throw RecipeFetchError.invalidURL(apiKey.rawValue)
        }
        let urlSession = URLSession.shared

        let (data, _) = try await urlSession.data(from: url)
        return try decoder.decode(RecipeResponse.self, from: data)
    }
}
