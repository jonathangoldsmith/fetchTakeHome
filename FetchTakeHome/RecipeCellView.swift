//
//  RecipeCellView.swift
//  FetchTakeHome
//
//  Created by Jonathan Goldsmith on 10/31/24.
//

import SwiftUI

struct RecipeCellView: View {
    let recipe: Recipe

    private enum Theme {
        static var imageSize: CGFloat = 64
        static var cornerRadius: CGFloat = 4
        static var horizontalSpacing: CGFloat = 16
        static var nameFont = Font.headline
        static var cuisineFont = Font.subheadline
        static var placeholderImageName = "fork.knife.circle"
    }

    var body: some View {
        HStack(alignment: .top, spacing: Theme.horizontalSpacing) {
            AsyncImage(url: recipe.imageDataURL ?? recipe.photoUrlSmall) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    Image(systemName: Theme.placeholderImageName)
                        .resizable()
                } else {
                    ProgressView()
                }
            }
            .frame(width: Theme.imageSize, height: Theme.imageSize)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: Theme.cornerRadius
                )
            )

            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(Theme.nameFont)
                Text(recipe.cuisine)
                    .font(Theme.cuisineFont)
            }
            Spacer()
        }
    }


}

#Preview {
    RecipeCellView(
        recipe: Recipe(
            id: UUID(),
            cuisine: "Malaysian",
            name: "Apam Balik",
            photoUrlLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg")!,
            photoUrlSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!,
            sourceUrl: nil,
            youtubeUrl: nil)
    )
}
