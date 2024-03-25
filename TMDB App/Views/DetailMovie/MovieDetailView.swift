//
//  MovieDetailView.swift
//  TMDB App
//
//  Created by Carlos Paredes on 23/3/24.
//

import SwiftUI

struct MovieDetailView: View {
    
    //MARK: - PROPERTIES
    @ObservedObject private var viewModel: MovieDetailViewModel
    @StateObject private var saveViewModel = MovieSaveViewModel()
    
    var movie: MovieDetailModel?
    
    // MARK: - INIT
    init(viewModel: MovieDetailViewModel) {
        self.movie = viewModel.movieDetails
        self.viewModel = viewModel
    }

    @State private var pulsate: Bool = false
    @State private var imagesList = [String]()
    @State private var isSaved: Bool = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            if let movie = movie {
                LazyVStack(alignment: .center, spacing: 0) {
                    //IMAGE
                    AsyncImage(url: URL.getBackDropPath(movie.backdropPath ?? ""), transaction: Transaction(animation: .spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.25))) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .imageModifier()
                                .transition(.scale)
                        case .failure(_):
                            Image(systemName: "ant.circle.fill").iconModifier()
                        case .empty:
                            Image(systemName: "photo.circle.fill").iconModifier()
                        @unknown default:
                            ProgressView()
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            //TITLE
                            Text(movie.title ?? "")
                                .font(.system(.title, design: .serif))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .padding(.top, 10)
                            Spacer()
                            //Saved button
                            Button(action: {
                                saveViewModel.saveMovie(movie)
                                isSaved = true
                            }) {
                                Image(systemName: isSaved ? "heart.fill" : "heart")
                                    .foregroundColor(isSaved ? .red : .gray)
                            }
                            .padding()
                        }
                        
                        //GENRES
                        if let genres = movie.genres {
                            GenresView(genres: genres.map{ $0.name ?? "" })
                        }
                            
                        //GENERALINFO
                        HStack {
                            if let runtime = movie.runtime {
                                GeneralDataView(name: "Length", value: "\(runtime) min")
                            }
                            if let voteAverage = movie.voteAverage {
                                GeneralDataView(name: "IMDB", value: "\(Int(voteAverage))/10")
                            }
                            if let revenue = movie.revenue {
                                GeneralDataView(name: "Revenue", value: "\(Double(revenue).formatAsCurrency())")
                            }
                        }
                        //RATING
                        Text("Rating:")
                            .modifier(TitleModifier())
                        RatingView(rating: Int(round(movie.voteAverage ?? 1/2)))
                            .padding(.bottom)
                        //OVERVIEW
                        Text("Overview:")
                            .modifier(TitleModifier())
                        Text(movie.overview ?? "")
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .font(.system(.body, design: .serif))
                            .frame(minHeight: 100)
                        
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 12)
                    
                    VStack(alignment: .leading, spacing: 30) {
                        //IMAGES CAROUSEL
                        if let images = viewModel.movieImages,
                           let backdrops = images.backdrops {
                            ImageCarouselView(images: backdrops.prefix(15).map { $0.filePath ?? "" })
                                .padding(.bottom, 10)
                        } else {
                            EmptyView()
                        }
                        
                        //Trailer Video
                        TrailerVideoView(movieKeys: viewModel.movieTrailers)
                            
                        //CREW
                        CrewView(crew: viewModel.movieCast)
                        
                        //SIMILAR MOVIES
                        SimilarMoviesView(id: movie.id)
                        
                        //WHERE TO WATCH
                        WatchProvidersView(title: "Where To Watch:", providers: viewModel.movieWatchProviderWatch)
                        
                        //RENT
                        WatchProvidersView(title: "Rent:", providers: viewModel.movieWatchProviderRent)
                        
                        //Buy
                        WatchProvidersView(title: "Buy:", providers: viewModel.movieWatchProviderBuy)
                        
                    }
                    .padding(.horizontal, 5)
                    .padding(.vertical, 8)
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .onAppear(){
            self.pulsate.toggle()
            viewModel.loadMovieImages()
            viewModel.loadMovieTrailer()
            viewModel.loadMovieCrew()
            viewModel.loadMovieWatchProviders()
            
            if let movie = movie {
                let savedMovies = saveViewModel.loadSavedMovies()
                isSaved = savedMovies.contains(where: { $0.id == movie.id })
            }
        }
    }
}

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.body, design: .serif))
            .fontWeight(.semibold)
            .foregroundColor(.gray)
    }
}

#Preview {
    MovieDetailView(viewModel: MovieDetailViewModel(movie: movieModelData))
}
