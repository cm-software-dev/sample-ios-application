//
//  ItunesServiceProtocol.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 08/05/2025.
//
import Combine

protocol GetItunesTracksUseCaseProtocol {
    func fetchTracks(forTerm term: String) -> AnyPublisher<[ItunesTrack], Error>
}
