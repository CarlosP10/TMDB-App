//
//  FavoritesViewController.swift
//  TMDB App
//
//  Created by Carlos Paredes on 21/3/24.
//

import UIKit
import SwiftUI

class FavoritesViewController: UIViewController, FavoritesListViewDelegate {
    private let movieListView = FavoritesListView()
    
    let backButton = UIBarButtonItem(customView: UIView())
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Favorites"
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        movieListView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func setUpView() {
        movieListView.delegate = self
        view.addSubview(movieListView)
        NSLayoutConstraint.activate([
            movieListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            movieListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            movieListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    //MARK: - MovieListViewDelegate
    func movieListView(_ movieList: FavoritesListView, didSelectMovie movie: MovieDetailModel) {
        print(String(describing: movie))
        let viewModel = MovieDetailViewModel(movie: movie.toMovie())
        spinner.startAnimating()
        viewModel.loadMovieDetails { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                if success {
                    self.spinner.stopAnimating()
                    DispatchQueue.main.async {
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                        let detailVC = UIHostingController(rootView: MovieDetailView(viewModel: viewModel))
                        detailVC.navigationItem.largeTitleDisplayMode = .never
                        detailVC.navigationItem.backBarButtonItem = self.backButton
                        self.navigationController?.pushViewController(detailVC, animated: true)
                    }
                } else {
                    self.spinner.stopAnimating()
                    self.showAlert(title: "Error", message: "Unable to load detail.")
                }
            case .failure(_):
                self.spinner.stopAnimating()
                self.showAlert(title: "Error", message: "Unable to load detail.")
            }
        }
    }


}
