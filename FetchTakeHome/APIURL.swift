//
//  APIURL.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/29/24.
//

import Foundation

/// Convienience to reduce need of magic strings
enum APIURL: String {
    case validRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    case malformedRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    case emptyRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
}
