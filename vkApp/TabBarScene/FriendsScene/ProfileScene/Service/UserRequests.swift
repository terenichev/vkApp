//
//  UserRequests.swift
//  vkApp
//
//  Created by Денис Тереничев on 25.05.2022.
//

import UIKit

class UserRequests {
    
    var imageCache = NSCache<NSString, UIImage>()
    
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
            URLQueryItem(name: "fields", value: "about, followers_count, has_mobile, photo_200_orig, is_friend, last_seen, online, status"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlGetUserData = urlForUserDataComponents.url else { return }
        session.dataTask(with: urlGetUserData) { (data, response, error) in
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
    
    ///Запрос фотографий пользователя по его id
    func friendsPhotoRequest(id: Int, completion: @escaping (Result<[Item], Error>) -> Void) {
        var urlComponentsGetPhotos = URLComponents()
        urlComponentsGetPhotos.scheme = "https"
        urlComponentsGetPhotos.host = "api.vk.com"
        urlComponentsGetPhotos.path = "/method/photos.get"
        urlComponentsGetPhotos.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(id)"),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlGetPhotos = urlComponentsGetPhotos.url
        else { return }
        session.dataTask(with: urlGetPhotos) { (data, response, error) in
            if let error = error {
                print("some error")
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let photoResponceFromJSON = try JSONDecoder().decode(UserPhotoURLResponse.self, from: data).response.items
                DispatchQueue.main.async {
                    completion(.success(photoResponceFromJSON))
                }
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(.failure(jsonError))
            }
        }.resume()
    }
}

extension UserRequests {
    ///Загрузка изображения по URL
    func imageLoader(url: URL?, completion: @escaping (UIImage) -> Void) {
        guard let url = url else {
            print("image url nil")
            return
        }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage )
        } else {
            let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10)
            self.session.dataTask(with: request) { [weak self] data, response, error in
                guard error == nil, data != nil
                else {
                    print("error to download image, error = ", error)
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
