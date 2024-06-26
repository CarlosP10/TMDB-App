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
    
    let viewModel = MovieListViewViewModel()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let haptic = UISelectionFeedbackGenerator()
    
    let segmentedViews: UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.backgroundColor = .clear
        segmented.tintColor = .clear
        segmented.alpha = 0
        segmented.setTitleTextAttributes([.foregroundColor : UIColor.label ], for: .selected)
        segmented.setTitleTextAttributes([.foregroundColor : UIColor.secondaryLabel], for: .normal)
        segmented.translatesAutoresizingMaskIntoConstraints = false
        return segmented
    }()
    
    let collectionView: UICollectionView = {
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
            
            segmentedViews.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            segmentedViews.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            segmentedViews.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            segmentedViews.heightAnchor.constraint(equalToConstant: 40),
            
            collectionView.topAnchor.constraint(equalTo: segmentedViews.bottomAnchor, constant: 15),
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
    func viewChanged(_ sender: UISegmentedControl) {
        haptic.selectionChanged()
        spinner.startAnimating()
        collectionView.alpha = 0.1
        collectionView.reloadData()
        viewModel.didChangeSegment(to: sender.selectedSegmentIndex)
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
}

//MARK: - MovieListViewViewModelDelegate

extension MovieListView: MovieListViewViewModelDelegate {
    func didChangeSement() {
        collectionView.scrollToTop()
    }
    
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
        delegate?.movieListView(self, didSelectMovie: movie)
    }
    
    
}
