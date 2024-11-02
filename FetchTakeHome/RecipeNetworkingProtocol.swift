//
//  RecipeNetworkingProtocol.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/29/24.
//

/// Protocol to fetch Recipes, which is Mocked in the MockNetworkingManager
protocol RecipeNetworkingProtocol {
    func fetchRecipes() async throws -> RecipeResponse
}
