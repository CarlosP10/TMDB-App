@testable import TMDB_App
import XCTest

final class MovieListViewViewModelTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in MovieListViewViewModelTests")
    //    }
    
    var viewModel: MovieListViewViewModel!
    var delegateMock: MovieListViewViewModelDelegateMock!
    
    override func setUp() {
        super.setUp()
        viewModel = MovieListViewViewModel()
        delegateMock = MovieListViewViewModelDelegateMock()
        viewModel.delegate = delegateMock
    }
    
    override func tearDown() {
        viewModel = nil
        delegateMock = nil
        super.tearDown()
    }
    
    func testFetchMovies() {
        let expectation = XCTestExpectation(description: "Movies fetched")
        // Execute
        viewModel.fetchMovies()
        // Verify
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.currentPage, 1)
            XCTAssertGreaterThan(self.viewModel.totalPages, 0)
            XCTAssertFalse(self.viewModel.movies.isEmpty)
            XCTAssertFalse(self.viewModel.cellViewModels.isEmpty)
            XCTAssertEqual(self.delegateMock.didLoadInitialMoviesCallCount, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchMoreMovies() {
        let expectation = XCTestExpectation(description: "More movies fetched")
        // Execute
        viewModel.fetchNextPage()
        // Verify
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.viewModel.currentPage > 1)
            XCTAssertGreaterThan(self.viewModel.totalPages, 0)
            XCTAssertFalse(self.viewModel.movies.isEmpty)
            XCTAssertFalse(self.viewModel.cellViewModels.isEmpty)
            XCTAssertEqual(self.delegateMock.didLoadMoreMoviesCallCount, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testDidChangeSegment() {
        let selectedIndex = 1
        // Execute
        viewModel.didChangeSegment(to: selectedIndex)
        // Verify
        XCTAssertEqual(viewModel.selectedSection, selectedIndex)
        XCTAssertEqual(viewModel.currentPage, 1)
        XCTAssertTrue(viewModel.movies.isEmpty)
        XCTAssertTrue(viewModel.cellViewModels.isEmpty)
        XCTAssertEqual(delegateMock.didChangeSementCallCount, 1)
    }
    
    func testCollectionViewDataSource() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        // Execute
        let numberOfRows = viewModel.collectionView(collectionView, numberOfItemsInSection: 0)
        // Verify
        XCTAssertEqual(numberOfRows, viewModel.cellViewModels.count)
    }
}
