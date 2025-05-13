//
//  TrackBuilder.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 07/05/2025.
//

@testable import ItunesSummary
import Foundation

//was created to easily build tracks for testing but is also useful for Previews

class TrackBuilder {
    
    private var track = ItunesTrack(trackID: 0,
                                    artistName: "Journey",
                                    trackName: "Don't Stop Believin' (2024 Remaster)",
                                    trackPrice: 0.99,
                                    currency: "USD",
                                    artworkUrl100: "https://is1-ssl.mzstatic.com/image/thumb/Music116/v4/71/2d/61/712d617d-f4a4-5904-1b11-d4b4b45c47c5/828768588925.jpg/100x100bb.jpg",
                                    trackTimeMillis: 200000,
                                    releaseDate: "1981-06-03T07:00:00Z",
                                    trackViewURL: "https://music.apple.com/us/album/dont-stop-believin-2024-remaster/169003304?i=169003415&uo=4"
                                   )
    
    func withTrackId(_ id: Int) -> TrackBuilder {
        track.trackID = id
        return self
    }
    
    func withArtistName(_ name: String) -> TrackBuilder {
        track.artistName = name
        return self
    }
    
    func withTrackName(_ name: String) -> TrackBuilder {
        track.trackName = name
        return self
    }
    
    func withPrice(_ price: Double) -> TrackBuilder {
        track.trackPrice = price
        return self
    }
    
    func withCurrency(_ currency: String) -> TrackBuilder {
        track.currency = currency
        return self
    }
    
    func withArtworkURL100(_ urlString: String) -> TrackBuilder {
        track.artworkUrl100 = urlString
        return self
    }
    
    func withDuration(_ duration: Int) -> TrackBuilder {
        track.trackTimeMillis = duration
        return self
    }
    
    func withReleaseDate(_ dateString: String) -> TrackBuilder {
        track.releaseDate = dateString
        return self
    }
    
    func withTrackViewURL(_ urlString: String) -> TrackBuilder {
        track.trackViewURL = urlString
        return self
    }
    
    func build() -> ItunesTrack {
        return track
    }
    
    func build(thisMany number: Int) -> [ItunesTrack]{
        var array: [ItunesTrack] = []
        guard number < 1000 && number > 0 else {return array}
        
        for i in 1...number {
            array.append(withTrackId(i).build())
        }
        return array
    }
    
}
