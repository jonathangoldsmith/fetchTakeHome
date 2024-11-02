//
//  RecipeListView.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/29/24.
//

import SwiftUI

struct RecipeListView: View {

    // I used line 14 to test different endpoints, in production code I would remove the comment
    @StateObject private var viewModel = RecipeViewModel(
//        with: RecipeNetworkingManager(apiKey: .emptyRecipes)
    )

    var body: some View {
        NavigationStack {
            List(viewModel.filteredRecipes) { recipe in
                RecipeCellView(recipe: recipe)
                    .task { try? await viewModel.downloadImage(for: recipe) }
            }
            .listStyle(.plain)
            .navigationTitle("Recipes")
            .task {
                try? await viewModel.fetchRecipes()
            }
            .alert(viewModel.displayError?.localizedDescription ?? "", isPresented: $viewModel.showAlert) {
                Button("Dismiss") {
                    viewModel.dismissAlert()
                }
            }
            .refreshable {
                try? await viewModel.fetchRecipes()
            }
            .searchable(text: $viewModel.searchText)
            .overlay {
                if viewModel.filteredRecipes.count == 0 {
                    emptyView
                }
            }
        }
    }

    @ViewBuilder
    private var emptyView: some View {
        Text("No Recipes Found")
            .font(.largeTitle)
    }
}

#Preview {
    RecipeListView()
}
