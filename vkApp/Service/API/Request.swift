//
//  Request.swift
//  vkApp
//
//  Created by Денис Тереничев on 05.05.2022.
//

import Foundation

protocol RequestProtocol {
    func usersIdsRequest(url: URL, completion: @escaping(Result<[Int], Error>) -> Void)
    func usersInfoRequest(url: URL, completion: @escaping (Result<DTO.Response, Error>) -> Void)
}

class Request: RequestProtocol {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    func usersInfoRequest(url: URL, completion: @escaping (Result<DTO.Response, Error>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.sync {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                
                do {
                    let usersFromJSON = try JSONDecoder().decode(DTO.Response.self, from: data)
                    
                    completion(.success(usersFromJSON))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    func usersIdsRequest(url: URL, completion: @escaping (Result<[Int], Error>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.sync {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                
                do {
                    let usersIdsArrayFromJSON = try JSONDecoder().decode(UsersIdsArray.self, from: data).response.ids
                    
                    completion(.success(usersIdsArrayFromJSON))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
}
