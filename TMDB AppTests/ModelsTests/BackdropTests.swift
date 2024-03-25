@testable import TMDB_App
import XCTest

final class BackdropTests: XCTestCase {
    //    func test_zero() throws {
    //        XCTFail("Tests not yet implemented in BackdropTests")
    //    }
    
    func testInitializationWithValidData() {
        let aspectRatio = 1.5
        let height = 500
        let iso639_1 = "en"
        let filePath = "example is a test"
        let voteAverage = 7.5
        let voteCount = 1000
        let width = 1000
        
        let backdrop = Backdrop(
            aspectRatio: aspectRatio,
            height: height,
            iso639_1: iso639_1,
            filePath: filePath,
            voteAverage: voteAverage,
            voteCount: voteCount,
            width: width
        )
        
        XCTAssertEqual(backdrop.aspectRatio, aspectRatio)
        XCTAssertEqual(backdrop.height, height)
        XCTAssertEqual(backdrop.iso639_1, iso639_1)
        XCTAssertEqual(backdrop.filePath, filePath)
        XCTAssertEqual(backdrop.voteAverage, voteAverage)
        XCTAssertEqual(backdrop.voteCount, voteCount)
        XCTAssertEqual(backdrop.width, width)
    }
    
    func testDecodingFromJSON() {
        let json = """
            {
                "aspect_ratio": 1.5,
                "height": 500,
                "iso_639_1": "en",
                "file_path": "is just a test",
                "vote_average": 7.5,
                "vote_count": 1000,
                "width": 1000
            }
            """
        
        let jsonData = json.data(using: .utf8)!
        do {
            let backdrop = try JSONDecoder().decode(Backdrop.self, from: jsonData)
            XCTAssertEqual(backdrop.aspectRatio, 1.5)
            XCTAssertEqual(backdrop.height, 500)
            XCTAssertEqual(backdrop.iso639_1, "en")
            XCTAssertEqual(backdrop.voteAverage, 7.5)
            XCTAssertEqual(backdrop.voteCount, 1000)
            XCTAssertEqual(backdrop.width, 1000)
        } catch {
            XCTFail("Failed to decode Backdrop from JSON: \(error)")
        }
    }
}
