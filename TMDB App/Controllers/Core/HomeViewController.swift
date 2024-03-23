//
//  HomeViewController.swift
//  TMDB App
//
//  Created by Carlos Paredes on 21/3/24.
//

import UIKit

final class HomeViewController: UIViewController, MovieListViewDelegate {

    private let movieListView = MovieListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Explore"
        setUpView()
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
    func movieListView(_ movieList: MovieListView, didSelectMovie movie: MovieModel) {
        print(String(describing: movie))
    }
    
}
