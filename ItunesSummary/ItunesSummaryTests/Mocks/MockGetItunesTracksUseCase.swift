//
//  MockItunesService.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 08/05/2025.
//

@testable import ItunesSummary
import Foundation
import Combine

class MockGetItunesTracksUseCase: GetItunesTracksUseCaseProtocol {
    
    var testOutcome: TestOutcome
    var fetchTracksCallCounter = 0
    
    init(testOutcome: TestOutcome = .failure(error: AppError.test(description: "Test outcome not set"))) {
        self.testOutcome = testOutcome
    }
    
    func fetchTracks(forTerm term: String) -> AnyPublisher<[ItunesTrack], any Error> {
        fetchTracksCallCounter += 1
        switch testOutcome {
        case .success(let data):
            return Just(data as! [ItunesTrack])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
    
    
}
