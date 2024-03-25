@testable import TMDB_App
import XCTest

final class MovieListViewTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in MovieListViewTests")
    //    }
    
    var sut: MovieListView!
    
    override func setUp() {
        super.setUp()
        sut = MovieListView()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertNotNil(sut)
        XCTAssertTrue(sut.spinner.isAnimating)
        XCTAssertTrue(sut.collectionView.isHidden)
        XCTAssertEqual(sut.segmentedViews.selectedSegmentIndex, 0)
    }
    
    func testSegmentedViewSetup() {
        XCTAssertEqual(sut.segmentedViews.numberOfSegments, TMDBEndpoint.allCases.count)
    }
    
    func testViewChanged() {
        sut.viewChanged(sut.segmentedViews)
        XCTAssertTrue(sut.spinner.isAnimating)
        XCTAssertEqual(sut.collectionView.alpha, 1.0)
    }
}
