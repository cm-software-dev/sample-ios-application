//
//  ItunesService.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 07/05/2025.
//

import Combine
import Foundation

class ItunesService: GetItunesTracksUseCaseProtocol {
    private let networkService: NetworkServiceProtocol
    private let scheme = "https"
    private let host = "itunes.apple.com"
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchTracks(forTerm term: String = "rock") -> AnyPublisher<[ItunesTrack], any Error> {
        guard let url = buildURL(path: "/search", queryItems: [URLQueryItem(name: "term", value: term)]) else {
            let error = AppError.network(description: "Failed to build fetch url")
          return Fail(error: error).eraseToAnyPublisher()
        }
        
        return networkService.fetch(ItunesResponse.self, url: url)
            .map {(response: ItunesResponse) in
                print("Have results \(response.resultCount)")
                return response.results
            }
            .eraseToAnyPublisher()
    }
    
    private func buildURL(path: String, queryItems: [URLQueryItem]) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
