//
//  RecipeResponse.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/29/24.
//

/// If we wanted to add things to the response like pagination we can do that here
struct RecipeResponse: Codable {
    let recipes: [Recipe]
}
