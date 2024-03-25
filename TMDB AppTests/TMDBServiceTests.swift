@testable import TMDB_App
import XCTest

final class TMDBServiceTests: XCTestCase {
    
    func testLoadMethodSuccess() {
        let queryItems = [
            URLQueryItem(name: "page", value: String(1))
        ]
        let resource = Resource<ResultModel<MovieModel>>(url: URL.getMovie(.nowPlaying),endpoint: .nowPlaying, method: .get(queryItems))
        let expectation = XCTestExpectation(description: "Success result received")
        
        // llamada al metodo que se va a probar
        TMDBService.shared.load(resource) { result in
            switch result {
            case .success(_):
                // exitosa si el resultado es el modelo esperado
                expectation.fulfill()
            case .failure(let error):
                // falla si hay un error
                XCTFail("Expected success result, but received failure with error: \(error)")
            }
        }
        
        // esperar un tiempo para ejecutar
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testLoadMethodFailure() {
        let invalidURL = URL.getMovie
        let resource = Resource<MovieModel>(url: invalidURL)
        let expectation = XCTestExpectation(description: "Failure result received")
        
        // llamada al metodo que se va a probar
        TMDBService.shared.load(resource) { result in
            switch result {
            case .success(_):
                // exitosa si el resultado es el modelo esperado
                XCTFail("Expected failure result, but received success")
            case .failure(_):
                // falla si hay un error
                expectation.fulfill()
            }
        }
        
        // esperar un tiempo para ejecutar
        wait(for: [expectation], timeout: 10.0)
    }
}
