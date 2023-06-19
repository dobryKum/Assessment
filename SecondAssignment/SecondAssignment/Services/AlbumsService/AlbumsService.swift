//
//  AlbumsService.swift
//  SecondAssignment
//
//  Created by Tsimafei Zykau on 19.06.23.
//

import Foundation

protocol AlbumsServiceProtocol {
    func getAlbums(with artistName: String, completion: @escaping (Result<[Album], HTTPError>) -> Void)
}

final class AlbumsService: AlbumsServiceProtocol {
    
    // MARK: - Properties
    private var httpClient: HTTPClient
    
    // MARK: - Initialization
    init(httpClient: HTTPClient = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    // MARK: - Methods
    func getAlbums(with artistName: String, completion: @escaping (Result<[Album], HTTPError>) -> Void) {
        let request = HTTPRequest(endpoint: AlbumsEndpoint.albums(artistName: artistName),
                                  method: .get)
        httpClient.request(request: request) { result in
            let completion = { response in
                DispatchQueue.main.async { completion(response) }
            }
            switch result {
            case .success(let response):
                guard
                    response.statusCode == 200,
                    let data = response.data
                else {
                    completion(.failure(.unsuccessStatus(response.statusCode)))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(AlbumsResponse.self,
                                                            from: data)
                    completion(.success(response.results))
                } catch {
                    completion(.failure(.parsingError))
                }
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }
}
