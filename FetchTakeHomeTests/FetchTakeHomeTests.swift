//
//  FetchTakeHomeTests.swift
//  FetchTakeHomeTests
//
//  Created by Jonathan Goldsmith on 10/29/24.
//

import XCTest
@testable import FetchTakeHome

final class FetchTakeHomeTests: XCTestCase {
    func testAllRecipesViewModel() async throws {
        let viewModel = RecipeViewModel(with: MockNetworkingManager(resourceTitle: .AllRecipes))
        try await viewModel.fetchRecipes()
        XCTAssertEqual(viewModel.filteredRecipes.count, 63)
        viewModel.searchText = "Malaysian"
        XCTAssertEqual(viewModel.filteredRecipes.count, 2)
    }

    func testNoRecipesViewModel() async throws {
        let viewModel = RecipeViewModel(with: MockNetworkingManager(resourceTitle: .EmptyRecipes))
        try await viewModel.fetchRecipes()
        XCTAssertEqual(viewModel.filteredRecipes.count, 0)
        viewModel.searchText = "Malaysian"
        XCTAssertEqual(viewModel.filteredRecipes.count, 0)
    }

    func testMalformedRecipesViewModel() async throws {
        let viewModel = RecipeViewModel(with: MockNetworkingManager(resourceTitle: .MalformedRecipes))
        try await viewModel.fetchRecipes()
        XCTAssertNotNil(viewModel.displayError)
        XCTAssertTrue(viewModel.showAlert)
        viewModel.dismissAlert()
        XCTAssertNil(viewModel.displayError)
        XCTAssertFalse(viewModel.showAlert)
    }
}
