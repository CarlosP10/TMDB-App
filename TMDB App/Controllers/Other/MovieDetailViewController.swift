//
//  MovieDetailViewController.swift
//  TMDB App
//
//  Created by Carlos Paredes on 23/3/24.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private let viewModel: MovieDetailViewModel
    private let detailView: MovieDetailView
    
    //MARK: - Init
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        self.detailView = MovieDetailView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
