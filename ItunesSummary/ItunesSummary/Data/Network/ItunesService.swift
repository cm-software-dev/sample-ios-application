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
        guard let url = buildURL(path: "/search", queryItems: getQueryItemsForRequest(term)) else {
            let error = AppError.network(description: "Failed to build fetch url")
          return Fail(error: error).eraseToAnyPublisher()
        }
        
        return networkService.fetch(ItunesResponse.self, url: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .receive(on: DispatchQueue.global())
            .map {(response: ItunesResponse) in
                return response.results
            }
            .eraseToAnyPublisher()
    }
    
    private func getQueryItemsForRequest(_ term: String) -> [URLQueryItem] {
       
        let items = [
            URLQueryItem(name: ItunesQueryKeys.term.rawValue, value: term),
            URLQueryItem(name: ItunesQueryKeys.entity.rawValue, value: ItunesMusicEntityValues.song.rawValue),
            URLQueryItem(name: ItunesQueryKeys.country.rawValue, value: getCurrentRegionIdentifier())
        ]
        return items
    }
    
    private func getCurrentRegionIdentifier() -> String {
        return Locale.current.region?.identifier ?? "GB"
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


enum ItunesQueryKeys: String {
    case term = "term"
    case media = "media"
    case attributes = "attribute"
    case entity = "entity"
    case country = "country"
}

enum ItunesMusicEntityValues: String {
    case song = "song"
}
