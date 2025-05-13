//
//  ItunesServiceTests.swift
//  ItunesSummaryTests
//
//  Created by Calum Maclellan on 07/05/2025.
//
@testable import ItunesSummary
import XCTest

final class ItunesServiceTests: XCTestCase {

    var mockNetworkService: NetworkServiceMock!
    
    override func setUpWithError() throws {
        mockNetworkService = NetworkServiceMock()
    }

    func testFetchTracksCallsNetworkServiceAndReceivesResult()  {
        let service = ItunesService(networkService: mockNetworkService)
        let expectedResults = [TrackBuilder().withTrackId(1).build()]
        mockNetworkService.testOutcome = TestOutcome.success(data: ItunesResponse(resultCount: expectedResults.count, results: expectedResults))
        
        let exp = expectation(description: "get results")
        
        let cancellable = service.fetchTracks()
            .sink(receiveCompletion: {
                error in
                exp.fulfill()
            }, receiveValue: {
                result in
                XCTAssertNotNil(result)
                XCTAssertEqual(expectedResults.count, result.count)
                XCTAssertEqual(expectedResults.first!.trackID, result.first?.trackID)
            })
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(cancellable)
    }

    func testFetchTracksCallsNetworkServiceWithExpectedURL()  {
        let service = ItunesService(networkService: mockNetworkService)
        mockNetworkService.testOutcome = TestOutcome.success(data: ItunesResponse(resultCount: 0, results: []))
        
        let expectedUrlString = "https://itunes.apple.com/search?term=rock"
        let exp = expectation(description: "get results")
        
        let cancellable = service.fetchTracks()
            .sink(receiveCompletion: {
                error in
                exp.fulfill()
            }, receiveValue: {
                result in
            })
        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(cancellable)
        XCTAssertNotNil(mockNetworkService.lastURLPassed)
        XCTAssertEqual(mockNetworkService.lastURLPassed!.absoluteString, expectedUrlString)
    }
    
    
    
}
