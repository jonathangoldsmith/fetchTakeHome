//
//  RecipeFetchError.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/31/24.
//

import Foundation

/// This could include things like an API error to handle 400 errors
enum RecipeFetchError: Error {
    case invalidURL(_ string: String)
}
