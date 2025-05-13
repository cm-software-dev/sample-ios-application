//
//  NetworkService.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 07/05/2025.
//

import Foundation
import Combine

public class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    private let TIMEOUT_TIME: Int = 5
    
    init(session: URLSession = .shared) {
        let configuration = URLSessionConfiguration.ephemeral
        self.session = URLSession(configuration: configuration)
    }
    
    func fetch<T: Decodable>(_ t: T.Type, url: URL) -> AnyPublisher<T, Error> {
        print(url.absoluteString)
        return  session.dataTaskPublisher(for: URLRequest(url: url))
            .timeout(.seconds(TIMEOUT_TIME), scheduler: DispatchQueue.main, options: nil, customError: { URLError(.timedOut)})
            .subscribe(on: DispatchQueue.global(qos: .default))
            .receive(on: DispatchQueue.global(qos: .default))
            .mapError {
                error in
                print("NetworkService \(error.localizedDescription)")
                return AppError.network(description: error.localizedDescription)
            }
            .tryMap() { output -> Data in
                //catch any responses that are not 200
                guard let httpResponse = output.response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                    throw AppError.network(description: "Request failed. Response was not 200")
                  }
                return output.data
              }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError {
                error in
                print(error.localizedDescription)
                return AppError.parsing(description: "Error parsing JSON returned by request")
            }
            .eraseToAnyPublisher()
    }
 
}


protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(_ t: T.Type, url: URL) -> AnyPublisher<T, Error>
}
