//
//  NetworkServiceMock.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 07/05/2025.
//

@testable import ItunesSummary
import Combine
import Foundation

class NetworkServiceMock: NetworkServiceProtocol {
   

    var testOutcome: TestOutcome
    var lastURLPassed: URL?
    
    init(testOutcome: TestOutcome = .failure(error: AppError.test(description: "Test outcome not set"))) {
        self.testOutcome = testOutcome
    }
    
    func fetch<T>(_ t: T.Type, url: URL) -> AnyPublisher<T, any Error> where T : Decodable {
        lastURLPassed = url
        
        switch testOutcome {
        case .success(let data):
            return Just(data as! T)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
       
    }
}


enum TestOutcome {
    case success(data: Decodable)
    case failure(error: Error)
}
