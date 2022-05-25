//
//  Request.swift
//  vkApp
//
//  Created by Денис Тереничев on 05.05.2022.
//

import UIKit

class FriendsRequests {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    ///Запрос списка друзей текущего пользователя
    func loadFriendsList(_ completion: @escaping (Result<[FriendsItem], Error>) -> Void) {
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

extension FriendsRequests {
    ///Загрузка изображения по URL
    func imageLoader(url: URL?) -> UIImage {
        var image: UIImage
        if let data = try? Data(contentsOf: url!) {
            guard let imageFromUrl = UIImage(data: data) else { return UIImage(named: "not photo")!}
            image = imageFromUrl
        } else {
            image = UIImage(named: "not photo")!
        }
        return image
    }
}
