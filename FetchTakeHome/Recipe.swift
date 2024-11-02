//
//  Recipe.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/29/24.
//

import Foundation

struct Recipe: Codable, Identifiable {
    let id: UUID
    let cuisine: String
    let name: String
    let photoUrlLarge: URL
    let photoUrlSmall: URL
    let sourceUrl: URL?
    let youtubeUrl: URL?
    var imageDataURL: URL?

    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoUrlLarge
        case photoUrlSmall
        case sourceUrl
        case youtubeUrl
        case imageDataURL
    }
}
