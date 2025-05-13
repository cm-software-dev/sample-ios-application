//
//  TrackListView.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 07/05/2025.
//

import SwiftUI

struct TrackListView: View {
    
    @StateObject var viewModel = TrackListViewModel(service: ItunesService(networkService: NetworkService()))
    
    var body: some View {
        ZStack
        {
            NavigationView {
                MasterDetailView(viewModel: viewModel)
                    .onAppear {
                        viewModel.fetchTracks()
                    }
                    .alert("Error fetching tracks!", isPresented: $viewModel.errorFetching) {
                        Button("OK") {}
                    }
            }
            
            if (viewModel.isFetching)
            {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2.0, anchor: .center)
            }
                
        }
    }
}

#Preview {
    var vm = TrackListViewModel()
    vm.tracks = [TrackRowViewModel(track: TrackBuilder().build())]
    return TrackListView()
}


struct MasterDetailView: View {
    
    @ObservedObject var viewModel:TrackListViewModel
    
    var defaultDetailVM: TrackDetailViewModel {
        viewModel.defaultTrackDetailViewModel
    }
    
    var body: some View {
        List($viewModel.tracks, id: \.id) {
            $track in
            NavigationLink(destination:
                            TrackDetailView(viewModel: track.getDetailViewModel() )) {
                TrackRowView(viewModel: track)
            }
        }
        .searchable(text: $viewModel.searchTerm)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.title).font(.title)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            viewModel.fetchTracks()
        }
        TrackDetailView(viewModel: defaultDetailVM)
    }
}

#Preview {
    var vm = TrackListViewModel()
    vm.tracks = [TrackRowViewModel(track: TrackBuilder().build())]
    return MasterDetailView(viewModel: vm)
}
