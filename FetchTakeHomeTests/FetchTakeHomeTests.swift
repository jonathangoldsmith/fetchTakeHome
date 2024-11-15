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

    func testSearchFunctionalityGuardStatement() async throws {
        let viewModel = RecipeViewModel(with: MockNetworkingManager(resourceTitle: .AllRecipes))
        try await viewModel.fetchRecipes()
        viewModel.searchText = ""
        let totalCount = viewModel.filteredRecipes.count
        // expect to return all results
        XCTAssertEqual(viewModel.filteredRecipes.count, totalCount)
    }

    func testSearchFunctionalityLowercase() async throws {
        let viewModel = RecipeViewModel(with: MockNetworkingManager(resourceTitle: .AllRecipes))
        try await viewModel.fetchRecipes()
        viewModel.searchText = "Malaysian".lowercased()
        // expect to return 2 malaysian objects
        XCTAssertEqual(viewModel.filteredRecipes.count, 2)
    }

    func testSearchFunctionalityUppercase() async throws {
        let viewModel = RecipeViewModel(with: MockNetworkingManager(resourceTitle: .AllRecipes))
        try await viewModel.fetchRecipes()
        viewModel.searchText = "Malaysian".uppercased()
        XCTAssertEqual(viewModel.filteredRecipes.count, 2)
        // expect to return 2 malaysian objects
    }

    func testSearchFunctionalityName() async throws {
        let viewModel = RecipeViewModel(with: MockNetworkingManager(resourceTitle: .AllRecipes))
        try await viewModel.fetchRecipes()
        viewModel.searchText = "Apple"
        XCTAssertEqual(viewModel.filteredRecipes.count, 3)
        // expect to return apple objects
    }

    func testSearchFunctionalityCuisine() async throws {
        let viewModel = RecipeViewModel(with: MockNetworkingManager(resourceTitle: .AllRecipes))
        try await viewModel.fetchRecipes()
        viewModel.searchText = "Malaysian"
        XCTAssertEqual(viewModel.filteredRecipes.count, 2)
    }

    func testSearchFunctionalityCuisineAndName() async throws {
        let viewModel = RecipeViewModel(with: MockNetworkingManager(resourceTitle: .AllRecipes))
        try await viewModel.fetchRecipes()
        viewModel.searchText = "a"
        XCTAssertEqual(viewModel.filteredRecipes.count, 58)
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
