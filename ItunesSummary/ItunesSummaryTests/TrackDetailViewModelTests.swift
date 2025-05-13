//
//  TrackDetailViewModelTests.swift
//  ItunesSummaryTests
//
//  Created by Calum Maclellan on 07/05/2025.
//
@testable import ItunesSummary
import XCTest

final class TrackDetailViewModelTests: XCTestCase {

    var viewModel: TrackDetailViewModel!
    var track: ItunesTrack!
    
    override func setUpWithError() throws {
        track = TrackBuilder()
            .withPrice(0.99)
            .withCurrency("GBP")
            .withDuration(200000)
            .withReleaseDate("1981-06-03T07:00:00Z")
            .withTrackViewURL("https://music.apple.com/us/album/dont-stop-believin-2024-remaster/169003304?i=169003415&uo=4")
            .build()
        viewModel = TrackDetailViewModel(track: track)
    }
    
    func testViewModelReturnsArtistName() {
        let expected = track.artistName
        XCTAssertEqual(expected, viewModel.artistName)
    }
    
    func testViewModelReturnsImageURL() {
        let expected = URL(string: track.artworkUrl100)
        XCTAssertNotNil(viewModel.imageURL)
        XCTAssertEqual(expected, viewModel.imageURL)
    }
    
    func testViewModelReturnsTrackName() {
        let expected = track.trackName
        XCTAssertEqual(expected, viewModel.trackName)
    }
    
    func testViewModelReturnsFormattedPrice() {
        let expected = "£ 0.99"
        XCTAssertEqual(expected, viewModel.price)
    }
    
    func testViewModelReturnsFormattedDuration() {
        let expected = "3:20"
        XCTAssertEqual(expected, viewModel.duration)
    }
    
    func testViewModelReturnsFormattedReleaseDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ssZ"
        let expected = formatter.date(from: track.releaseDate)?.formatted(date: .long, time: .omitted) ?? "Failed"
        XCTAssertEqual(expected, viewModel.releaseDate)
    }
    
    func testViewModelReturnsTrackViewURL() {
        let expected = URL(string: track.trackViewURL)
        XCTAssertNotNil(viewModel.trackViewURL)
        XCTAssertEqual(expected, viewModel.trackViewURL)
    }
    

}
