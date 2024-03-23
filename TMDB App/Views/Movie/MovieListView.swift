//
//  MovieListView.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import UIKit

protocol MovieListViewDelegate: AnyObject {
    func movieListView(
        _ movieList: MovieListView,
        didSelectMovie movie: MovieModel
    )
}

final class MovieListView: UIView {
    
    public weak var delegate: MovieListViewDelegate?
    
    private let viewModel = MovieListViewViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let haptic = UISelectionFeedbackGenerator()
    
    private let segmentedViews: UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.backgroundColor = .clear
        segmented.tintColor = .clear
        segmented.alpha = 0
        segmented.setTitleTextAttributes([.foregroundColor : UIColor.label ], for: .selected)
        segmented.setTitleTextAttributes([.foregroundColor : UIColor.secondaryLabel], for: .normal)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
        collectionView.register(FooterLoadingCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: FooterLoadingCollectionReusableView.identifier)
        return collectionView
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(segmentedViews, collectionView, spinner)
        addConstraints()
        spinner.startAnimating()
        viewModel.delegate = self
        viewModel.fetchMovies()
        setUpCollectionView()
        setUpSegmentedView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            segmentedViews.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            segmentedViews.leadingAnchor.constraint(equalTo: leadingAnchor),
            segmentedViews.trailingAnchor.constraint(equalTo: trailingAnchor),
            segmentedViews.heightAnchor.constraint(equalToConstant: 50),
            
            collectionView.topAnchor.constraint(equalTo: segmentedViews.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    private func setUpSegmentedView() {
        haptic.prepare()
        segmentedViews.removeAllSegments()
        
        for (index, value) in TMDBEndpoint.allCases.enumerated() {
            segmentedViews.insertSegment(withTitle: value.title, at: index, animated: true)
        }
        segmentedViews.selectedSegmentIndex = 0
        segmentedViews.addTarget(self, action: #selector(viewChanged), for: .valueChanged)
    }
    
    @objc
    private func viewChanged(_ sender: UISegmentedControl) {
        haptic.selectionChanged()
        spinner.startAnimating()
        collectionView.reloadData()
        viewModel.didChangeSegment(to: sender.selectedSegmentIndex)
    }
}

//MARK: - MovieListViewViewModelDelegate

extension MovieListView: MovieListViewViewModelDelegate {
    
    func didLoadInitialMovies() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()//Initial fetch
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
            self.segmentedViews.alpha = 1
        }
    }
    
    func didLoadMoreMovies(with newIndexPaths: [IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPaths)
        }
    }
    
    func didSelectMovie(_ movie: MovieModel) {
        print(String(describing: movie))
    }
    
    
}
