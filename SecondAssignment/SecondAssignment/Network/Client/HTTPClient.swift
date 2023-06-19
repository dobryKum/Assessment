//
//  HTTPClient.swift
//  SecondAssignment
//
//  Created by Tsimafei Zykau on 19.06.23.
//

import Foundation

protocol HTTPClientProtocol: AnyObject {
    func request(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void)
}

final class HTTPClient: HTTPClientProtocol {
    // MARK: - Methods
    func request(request: HTTPRequest, completion: @escaping (HTTPResult) -> Void) {
        guard let url = request.endpoint.url else {
            completion(.failure(.incorrectUrl))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error as NSError? {
                if error.code == NSURLErrorTimedOut {
                    completion(.failure(.timeout))
                } else {
                    completion(.failure(.networkError(error)))
                }
                return
            }
            
            guard let response = urlResponse as? HTTPURLResponse else {
                completion(.failure(.undefined))
                return
            }
            
            let headers: HTTPHeaders
            if let responseHeaders = response.allHeaderFields as? [String: String] {
                headers = responseHeaders
            } else {
                headers = [:]
            }
            
            switch response.statusCode {
            case 200...300:
                let response = HTTPResponse(statusCode: response.statusCode,
                                            headers: headers,
                                            data: data)
                completion(.success(response))
            default:
                completion(.failure(.unsuccessStatus(response.statusCode)))
            }
        }
        dataTask.resume()
    }
}
