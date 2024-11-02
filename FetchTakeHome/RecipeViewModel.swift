//
//  RecipeViewModel.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/29/24.
//

import Foundation
import Combine
import SwiftUI

final class RecipeViewModel: ObservableObject, RecipeViewModelProtocol {

    private let networkingManager: RecipeNetworkingProtocol
    @Published private var initialRecipes: [Recipe] = []
    @Published var displayError: Error? = nil
    @Published var showAlert = false
    @Published var searchText: String = ""
    private let session = URLSession(configuration: .default)

    var filteredRecipes: [Recipe] {
        guard !searchText.isEmpty else { return initialRecipes }
        let filteredRecipes = initialRecipes.filter { recipe in  recipe.name.lowercased().contains(searchText.lowercased()) || recipe.cuisine.lowercased().contains(searchText.lowercased()) }
        return filteredRecipes
    }

    init(with networkingManager: RecipeNetworkingProtocol = RecipeNetworkingManager()) {
        self.networkingManager = networkingManager
    }

    func fetchRecipes() async throws {
        do {
            let response = try await networkingManager.fetchRecipes()
            await updateRecipes(response: response)
        } catch let recipeFetchError {
            await updateErrorState(fetchErorr: recipeFetchError)
        }
    }

    func downloadImage(for recipe: Recipe) async throws {
        guard let index = initialRecipes.firstIndex(where: { $0.id == recipe.id }),
              initialRecipes[index].imageDataURL == nil
        else { return }
        let (data, _) = try await session.data(from: recipe.photoUrlSmall)
        let dataURL = URL(string: "data:image/png;base64," + data.base64EncodedString())
        await updateRecipeImage(for: index, dataURL: dataURL)
    }

    @MainActor
    private func updateRecipeImage(for index: Array.Index, dataURL: URL?) {
        initialRecipes[index].imageDataURL = dataURL
    }

    @MainActor
    private func updateRecipes(response: RecipeResponse) {
        initialRecipes = response.recipes
    }

    @MainActor
    private func updateErrorState(fetchErorr: Error) {
        displayError = fetchErorr
        showAlert = true
    }

    func dismissAlert() {
        showAlert = false
        displayError = nil
    }
}
