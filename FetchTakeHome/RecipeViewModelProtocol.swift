//
//  RecipeViewModelProtocol.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/29/24.
//

/// If we wanted to mock out a RecipeViewModel to test a View's interactions with the ViewModel they would conform to this protocol
protocol RecipeViewModelProtocol {
    func fetchRecipes() async throws
    func downloadImage(for recipe: Recipe) async throws
}
