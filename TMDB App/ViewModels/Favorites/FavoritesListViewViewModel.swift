//
//  FavoritesListViewViewModel.swift
//  TMDB App
//
//  Created by Carlos Paredes on 25/3/24.
//

import UIKit
import SwiftUI

protocol FavoritesListViewViewModelDelegate: AnyObject {
    func didLoadInitialMovies()
    func reloadData()
    func didSelectMovie(_ movie: MovieDetailModel)
}

/// View Model to handle movie list view logic
final class FavoritesListViewViewModel: NSObject {
    
    public weak var delegate: FavoritesListViewViewModelDelegate?

    private var isLoadingMoreMovies = false
    private(set) var currentPage = 1
    private(set) var totalPages = 1
    
    private var savedMoviesViewModel = MovieSaveViewModel()

    private(set) var movies: [MovieDetailModel]
    
    private(set) var cellViewModels = [MovieCollectionViewCellViewModel]()
    
    override init() {
        self.movies = savedMoviesViewModel.loadSavedMovies()
    }
    
    public func loadMovies() {
        movies = []
        movies = savedMoviesViewModel.loadSavedMovies()
        self.delegate?.reloadData()
    }
    
    public func loadInitialMovies() {
        if !movies.isEmpty {
            DispatchQueue.main.async {
                self.delegate?.didLoadInitialMovies()
            }
        }
    }
}

//MARK: - CollectionView

extension FavoritesListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.cellIdentifier,
            for: indexPath
        )
        let movie = movies[indexPath.row].toMovie()
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

