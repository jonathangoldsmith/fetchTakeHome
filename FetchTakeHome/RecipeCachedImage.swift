//
//  RecipeCachedImage.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 11/12/24.
//

import SwiftUI


struct RecipeImageCache {
    private let urlSession = URLSession(configuration: .default)
    private var cache: [URL: Image]
    // url session which we will need to configure
    // func that takes in an url, caches it to disk if it is not on the disk, and returns that image, returns the image if it is on the disk
    // should this be a class function? Shared object? Maybe yes? actor
    // I want an actor per URL
    // our fetch functionlaity has the right Queue (userInitiated)
    func fetchImage(with url: URL) -> Image {
        if let image = cache[url] {
            return image
        } else {
            let task = urlSession.dataTask(with: url) { data, _, _ in
                guard let data else { return }
                DispatchQueue.main.async {
                    self.cache[url] = Image(data: data)
                }
            }
            
        }
    }
}

actor ImageFetcher {
    private let urlSession
    private let url : URL
}

struct RecipeCachedImage: View {
    var body: some View {
        EmptyView()
    }
}
