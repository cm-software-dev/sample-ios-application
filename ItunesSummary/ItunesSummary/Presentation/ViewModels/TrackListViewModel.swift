//
//  TrackListViewModel.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 07/05/2025.
//

import Foundation
import SwiftUI
import Combine

class TrackListViewModel: TrackListViewModelProtocol,  ObservableObject {
    
    @Published var tracks: [TrackRowViewModel] = [] {
        didSet {
            if !tracks.isEmpty {
                defaultTrackDetailViewModel = tracks.first!.getDetailViewModel()
            }
        }
    }
    
    @Published var isFetching = false
    @Published var errorFetching = false
    
    @Published var defaultTrackDetailViewModel: TrackDetailViewModel
    @Published var searchTerm: String = ""
    
    var title: String {
        "Tracks"
    }
    
    private let service: GetItunesTracksUseCaseProtocol
    private let defaultTerm = "rock"
    private var disposables = Set<AnyCancellable>()
    
    init(service: GetItunesTracksUseCaseProtocol = ItunesService()) {
        self.service = service
        defaultTrackDetailViewModel =  TrackDetailViewModel()
        self.debounceSearchTermChanges()
    }
    
    private func debounceSearchTermChanges() {
        $searchTerm
            .dropFirst(1)
                .debounce(for: 2, scheduler: RunLoop.main)
                .sink {
                    print("new text value: \($0)")
                    self.fetchTracks()
                }
                .store(in: &disposables)
        }
    
    
    func fetchTracks() {
        isFetching = true
        errorFetching = false
        service.fetchTracks(forTerm: !searchTerm.isEmpty ? searchTerm : defaultTerm)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .replaceError(with: [])
            .map {
                tracks in
                print("Is main thread \(Thread.isMainThread)")
                return tracks.map {TrackRowViewModel(track: $0)}.sorted(by: {$0.releaseDate  > $1.releaseDate})
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {
                [weak self] value in
                guard let self = self else {return}
                print("Setting isFetching false")
                self.isFetching = false
                switch value {
                case .failure:
                    self.tracks = []
                    self.errorFetching = true
                    print("Failed")
                case .finished:
                  break
                }
                
            }, receiveValue: {
                [weak self] trackResult in
                guard let self = self else {return}
                print("Setting trackResult")
                self.tracks = trackResult
            })
            .store(in: &disposables)
    }
    
}


protocol TrackListViewModelProtocol {
    
    func fetchTracks()
    
}
