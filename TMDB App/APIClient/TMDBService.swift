//
//  TMDBService.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import Foundation

///Handle error with enum case
enum NetworkError: Error {
    case invalidURL, invalidServerResponse, decodingError, invalidData
}

///Handle http method and pass parameters
enum HttpMethod {
    case get([URLQueryItem])
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}

/// blueprint for making HTTP requests and decoding
struct Resource<T: Codable> {
    let url: URL
    let endpoint: TMDBEndpoint?
    var headers: [String: String] = [:]
    var method: HttpMethod = .get([])
    
    init(url: URL, endpoint: TMDBEndpoint? = nil, headers: [String: String] = [:], method: HttpMethod = .get([])) {
        self.url = url
        self.endpoint = endpoint
        self.headers = headers
        self.method = method
    }
}

final class TMDBService {
    /// Shared singleton instance
    static let shared = TMDBService()
    
    private let cacheManager = APICacheManager()
    
    /// Privatized constructor
    private init() {}
    
    private let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMzRjZGI5ZmVkZWMxMzNhNTllNjg4ZDBkODBmMjllMyIsInN1YiI6IjVlOTBiNzhiZDM1ZGVhMDAxMTc1ZDM2NiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.A3UmaXgQbYE2fKn4elnJDfCdAV5zPn2XHWacKbN-VIo"
    
    /// executing HTTP requests, decoding their responses, and returning the decoded data
    /// - Parameter resource:  contains the details of the request
    /// - Returns: decoded T object,, representing the data retrieved from the server.
    func load<T: Codable>(_ resource: Resource<T>, completion: @escaping (Result<T, Error>) -> Void) {
        var fullURLString = resource.url.absoluteString

        if case .get(let queryItems) = resource.method {
            if !queryItems.isEmpty {
                if !fullURLString.contains("?") {
                    fullURLString += "?"
                } else {
                    fullURLString += "&"
                }
                let queryItemsString = queryItems.map { "\($0.name)=\($0.value ?? "")" }.joined(separator: "&")
                fullURLString += queryItemsString
            }
        }
        
        if let cachedData = cacheManager.cachedResponse(for: resource.endpoint, url: URL(string: fullURLString)) {
            do {
                let result = try JSONDecoder().decode(T.self, from: cachedData)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            return
        }
        
        var request = URLRequest(url: resource.url)
        switch resource.method {
        case .get(let queryItems):
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: true)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                completion(.failure(NetworkError.invalidURL))
                return
            }
            
            request = URLRequest(url: url)
        //default:
            //break
        }
        
        request.allHTTPHeaderFields = resource.headers
        request.httpMethod = resource.method.name
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = [
            "accept":"application/json",
            "Authorization": "Bearer "+apiKey
        ]
        
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.invalidData))
                return
            }
            
            do {
                // Cache the response
                self?.cacheManager.setCache(
                    for: resource.endpoint,
                    url: URL(string: fullURLString), 
                    data: data
                )
                
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }
        task.resume()
    }
    
    /// fetch and store image cache
    /// - Parameters:
    ///   - imageUrl: image url
    ///   - completion: to set if request succes or fails
    public func fetchImage(_ imageUrl: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        // TODO: Abstract to Image Manager
        guard let url = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
}
