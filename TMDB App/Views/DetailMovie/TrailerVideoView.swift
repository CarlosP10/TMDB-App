//
//  TrailerVideoView.swift
//  TMDB App
//
//  Created by Carlos Paredes on 23/3/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let movieKey: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: URL.getYoutubeTrailer(movieKey))
        uiView.load(request)
    }
}

struct TrailerVideoView: View {
    let movieKeys: [String]
    var body: some View {
        let screenBounds = UIScreen.main.bounds
        if !movieKeys.isEmpty {
            VStack(alignment:.leading) {
                let title = movieKeys.count > 1 ? "Trailers:" : "Trailer:"
                Text(title)
                    .modifier(TitleModifier())
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(movieKeys, id: \.self) { movieKey in
                            WebView(movieKey: movieKey)
                                .frame(width: screenBounds.width / 1.1, height: screenBounds.height / 4)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        else {
            EmptyView()
        }
    }
}

#Preview {
    TrailerVideoView(movieKeys: ["d2OONzqh2jk","_inKs4eeHiI"])
}
