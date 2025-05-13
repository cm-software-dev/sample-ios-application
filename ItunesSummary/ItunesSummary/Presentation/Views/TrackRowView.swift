//
//  TrackRowView.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 07/05/2025.
//

import SwiftUI

struct TrackRowView: View {
    
    private let viewModel: TrackRowViewModel
    private let rowHeight: CGFloat = 100
    private let imageWidth: CGFloat = 100
    
    init(viewModel: TrackRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            AsyncImage(url: viewModel.imageURL)
                .frame(width: imageWidth)
            
            VStack(alignment: .leading) {
                Text(viewModel.trackName)
                Text(viewModel.artistName)
                Spacer()
                Text(viewModel.price)
            }.padding()
            Spacer()
        }
        .frame(height: rowHeight)
        .padding()
    }
}

#Preview {
    TrackRowView(viewModel: TrackRowViewModel(track: TrackBuilder().build()))
}
