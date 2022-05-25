//
//  UserRequests.swift
//  vkApp
//
//  Created by Денис Тереничев on 25.05.2022.
//

import Foundation

class UserRequests {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    ///Запрос информации о выбранном пользователе
    func loadUserData(id: Int, completion: @escaping (Result<User, Error>) -> Void) {
        var urlForUserDataComponents = URLComponents()
        urlForUserDataComponents.scheme = "https"
        urlForUserDataComponents.host = "api.vk.com"
        urlForUserDataComponents.path = "/method/users.get"
        urlForUserDataComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: "\(id)"),
            URLQueryItem(name: "fields", value: "about, followers_count, has_mobile, photo_200_orig, is_friend, last_seen, online"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlGetIds = urlForUserDataComponents.url else { return }
        session.dataTask(with: urlGetIds) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let userFromJSON = try JSONDecoder().decode(UserResponse.self, from: data).response[0]
                DispatchQueue.main.async {
                    completion(.success(userFromJSON))
                }
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
}
