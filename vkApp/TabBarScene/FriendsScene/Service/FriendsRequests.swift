//
//  Request.swift
//  vkApp
//
//  Created by Денис Тереничев on 05.05.2022.
//

import UIKit
import PromiseKit

class FriendsRequests {
    
    var imageCache = NSCache<NSString, UIImage>()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    ///Запрос списка друзей текущего пользователя
    func loadFriendsList(_ completion: @escaping (Swift.Result<[FriendsItem], Error>) -> Void) {
        var urlLoadFriendsListComponents = URLComponents()
        urlLoadFriendsListComponents.scheme = "https"
        urlLoadFriendsListComponents.host = "api.vk.com"
        urlLoadFriendsListComponents.path = "/method/friends.get"
        urlLoadFriendsListComponents.queryItems = [
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "fields", value: "online, photo_50, status, photo_200_orig, photo_100"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlGetIds = urlLoadFriendsListComponents.url else { return }
        session.dataTask(with: urlGetIds) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let friendsArrayFromJSON = try JSONDecoder().decode(FriendModel.self, from: data).response.items
                DispatchQueue.main.async {
                    completion(.success(friendsArrayFromJSON))
                }
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(.failure(jsonError))
            }
        }.resume()
    }
}

extension FriendsRequests {
    ///Загрузка изображения по URL
    func imageLoader(url: URL?, completion: @escaping (UIImage) -> Void) {
        guard let url = url else {
            return
        }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage )
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            self.session.dataTask(with: request) { [weak self] data, response, error in
                guard error == nil, data != nil
                else {
                    print("error to download image, error = ", error as Any)
                    return }
                
                guard let image = UIImage(data: data!) else { return }
                self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }
    }
}


extension FriendsRequests {
    // 1. Создаем URL для запроса
    func getFriendsUrl() -> Promise<URL> {
        var urlLoadFriendsListComponents = URLComponents()
        urlLoadFriendsListComponents.scheme = "https"
        urlLoadFriendsListComponents.host = "api.vk.com"
        urlLoadFriendsListComponents.path = "/method/friends.get"
        urlLoadFriendsListComponents.queryItems = [
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "fields", value: "online, photo_50, status, photo_200_orig, photo_100"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        return Promise  { resolver in
            guard let url = urlLoadFriendsListComponents.url else {
                resolver.reject(AppError.notCorrectUrl)
                return
            }
            resolver.fulfill(url)
        }
    }

    // 2. Создаем запрос получили данные
    func getFriendsData(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            session.dataTask(with: url) {  (data, response, error) in
                guard let data = data else {
                    resolver.reject(AppError.errorTask)
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }

    // Парсим Данные
    func getParsedFriendsData(_ data: Data) -> Promise<[FriendsItem]> {
        return Promise  { resolver in
            do {
                let friendsArrayFromJSON = try JSONDecoder().decode(FriendModel.self, from: data).response.items
                print(friendsArrayFromJSON)
                resolver.fulfill(friendsArrayFromJSON)
            } catch {
                resolver.reject(AppError.failedToDecode)
            }
        }
    }
}
