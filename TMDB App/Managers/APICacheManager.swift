//
//  APICacheManager.swift
//  TMDB App
//
//  Created by Carlos Paredes on 22/3/24.
//

import Foundation

/// Manages in memory session scoped API caches
final class APICacheManager {
    // API URL: Data

    /// Cache map
    private var cacheDictionary: [
        TMDBEndpoint: NSCache<NSString, NSData>
    ] = [:]

    /// Constructor
    init() {
        setUpCache()
    }

    // MARK: - Public

    /// Get cached API response
    /// - Parameters:
    ///   - endpoint: Endpoiint to cahce for
    ///   - url: Url key
    /// - Returns: Nullable data
    public func cachedResponse(for endpoint: TMDBEndpoint?, url: URL?) -> Data? {
        guard let endpoint = endpoint, let targetCache = cacheDictionary[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }

    /// Set API response cache
    /// - Parameters:
    ///   - endpoint: Endpoint to cache for
    ///   - url: Url string
    ///   - data: Data to set in cache
    public func setCache(for endpoint: TMDBEndpoint?, url: URL?, data: Data) {
        guard let endpoint = endpoint, let targetCache = cacheDictionary[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }

    // MARK: - Private

    /// Set up dictionary
    private func setUpCache() {
        TMDBEndpoint.allCases.forEach({ endpoint in
            cacheDictionary[endpoint] = NSCache<NSString, NSData>()
        })
    }
}
