//
//  CrewView.swift
//  TMDB App
//
//  Created by Carlos Paredes on 23/3/24.
//

import SwiftUI

struct CrewView: View {
    //MARK: - PROPERTIES
    let crew: [Cast]
    
    //MARK: - UI
    var body: some View {
        let screenBounds = UIScreen.main.bounds
        if !crew.isEmpty {
            VStack(alignment: .leading) {
                Text("Crew:")
                    .modifier(TitleModifier())
                ScrollView(.horizontal, showsIndicators: true) {
                    HStack(spacing: 10) {
                        ForEach(crew, id: \.self) { item in
                            VStack(spacing:0) {
                                if let profilePath = item.profilePath {
                                    CrewProfileImageView(profilePath: profilePath)
                                } else {
                                    Image(systemName: "person.fill")
                                        .castModifier()
                                }
                                Text(item.name ?? "")
                                    .lineLimit(1)
                                    .multilineTextAlignment(.center)
                                    .font(.system(.body, design: .serif))
                            }
                            .frame(width: screenBounds.width / 3, height: screenBounds.height / 4)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, -15)
            }
        }
        else {
            EmptyView()
        }
    }
}

#Preview {
    CrewView(crew: crewData)
}
