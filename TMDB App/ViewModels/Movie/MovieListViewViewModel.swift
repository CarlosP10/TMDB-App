//
//  MovieListViewViewModel.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import UIKit
import SwiftUI

protocol MovieListViewViewModelDelegate: AnyObject {
    func didLoadInitialMovies()
    func didLoadMoreMovies(with newIndexPaths: [IndexPath])
    func didSelectMovie(_ movie: MovieModel)
    func didChangeSement()
}

/// View Model to handle movie list view logic
final class MovieListViewViewModel: NSObject {
    
    public weak var delegate: MovieListViewViewModelDelegate?

    private var isLoadingMoreMovies = false
    private(set) var currentPage = 1
    private(set) var totalPages = 1
    
    private(set) var movies: [MovieModel] = [] {
        didSet {
            for movie in movies {
                let viewModel = MovieCollectionViewCellViewModel(
                    title: movie.title ?? "", releaseDate: movie.releaseDate ?? "", 
                    starts: movie.voteAverage ?? 0.0, overview: movie.overview ?? "",
                    imageUrl: URL.getBackDropPath(movie.posterPath ?? "")
                )
                if !cellViewModels.contains(viewModel) {
                    cellViewModels.append(viewModel)
                }
            }
        }
    }
    
    private(set) var cellViewModels = [MovieCollectionViewCellViewModel]()
    public var tmdbEndpoints = TMDBEndpoint.allCases
    private var selectedEndpoint = TMDBEndpoint.nowPlaying
    private(set) var selectedSection = 0
    
    var canFetchNextPage: Bool {
        return !isLoadingMoreMovies && currentPage < totalPages
    }
    
    func fetchNextPage() {
        fetchMoreMovies(page: currentPage + 1)
    }
    
    func didChangeSegment(to index: Int) {
        selectedEndpoint = tmdbEndpoints[index]
        selectedSection = index
        currentPage = 1
        movies = []
        cellViewModels = []
        fetchMovies()
        delegate?.didChangeSement()
    }

    /// Fetch initial set of movies
    func fetchMovies() {
        let queryItems = [
            URLQueryItem(name: "page", value: String(currentPage))
        ]
        let resource = Resource<ResultModel<MovieModel>>(url: URL.getMovie(selectedEndpoint),endpoint: selectedEndpoint, method: .get(queryItems))
        
        TMDBService.shared.load(resource) { [weak self] result in
            switch result {
            case .success(let responseModel):
                guard let self = self else { return }
                let results = responseModel.results
                self.totalPages = responseModel.totalPages
                self.movies = results
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialMovies()
                }
                
            case .failure(let error):
                print(String(describing: error))
            }
        }
        
    }
    
    func fetchMoreMovies(page: Int) {
        guard !isLoadingMoreMovies else { return }
        isLoadingMoreMovies = true

        let queryItems = [
            URLQueryItem(name: "page", value: String(page))
        ]
        let resource = Resource<ResultModel<MovieModel>>(url: URL.getMovie(selectedEndpoint),endpoint: selectedEndpoint, method: .get(queryItems))
        
        TMDBService.shared.load(resource) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                self.currentPage = page
                
                let originalCount = self.movies.count
                let newCount = results.count
                let total = originalCount+newCount
                let statingIndex = total - newCount
                
                let indexPathsToAdd: [IndexPath] = Array(statingIndex..<(statingIndex+newCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                self.movies.append(contentsOf: results)
                
                DispatchQueue.main.async {
                    self.delegate?.didLoadMoreMovies(
                        with: indexPathsToAdd
                    )
                    self.isLoadingMoreMovies = false
                }
                
            case .failure(let error):
                print(String(describing: error))
                self.isLoadingMoreMovies = false
            }
        }
        
    }
    
}

//MARK: - CollectionView

extension MovieListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.cellIdentifier,
            for: indexPath
        )
        let movie = movies[indexPath.row]
        cell.contentConfiguration = UIHostingConfiguration(content: {
            MovieCollectionViewCell(movie: movie)
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: FooterLoadingCollectionReusableView.identifier,
                for: indexPath
              ) as? FooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard canFetchNextPage else {
            return .zero
        }

        return CGSize(width: collectionView.frame.width,
                      height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width: CGFloat
        if UIDevice.isiPhone {
            width = (bounds.width-30)/2
        } else {
            // mac | ipad
            width = (bounds.width-50)/4
        }

        return CGSize(
            width: width,
            height: width * 2
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = movies[indexPath.row]
        delegate?.didSelectMovie(movie)
    }
    
}

//MARK: - ScrollView
extension MovieListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard canFetchNextPage,
              !isLoadingMoreMovies,
              !cellViewModels.isEmpty else {
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchNextPage()
            }
            t.invalidate()
        }
              
    }
}
