//
//  RatingView.swift
//  TMDB App
//
//  Created by Carlos Paredes on 23/3/24.
//

import SwiftUI

struct RatingView: View {
    let rating: Int
    
    var label = ""

    var maximumRating = 5

    var offImage = Image(systemName: "star")
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack(spacing: 0) {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .padding(.horizontal, 0)
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: 2)
}
