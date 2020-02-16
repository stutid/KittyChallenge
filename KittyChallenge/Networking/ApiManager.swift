//
//  ApiManager.swift
//  KittyChallenge
//
//  Created by Stuti Dobhal on 16.02.20.
//  Copyright © 2020 Stuti Dobhal. All rights reserved.
//

import Foundation

final class ApiManager {
    static let shared = ApiManager()
    private init() {}
    private let session = URLSession.shared
    
    func fetch(request: URLRequest?, completionHandler: @escaping (Data?, Error?) -> ()) {
        guard let request = request else { return }
        let task = session.dataTask(with: request) { (data, response, error)  in
            if let data = data {
                completionHandler(data, nil)
            }
            if let error = error {
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
    func createRequest(url: URL?, method: HTTPMethod, data: Data? = nil) -> URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.type
        var header = ["x-api-key": "MTkxNzY4"]
        if method == .post {
            header["Content-Type"] = "application/json"
            request.httpBody = data
        }
        request.allHTTPHeaderFields = header
        return request
    }
}
