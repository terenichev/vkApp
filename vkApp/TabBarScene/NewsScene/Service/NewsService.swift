//
//  NewsService.swift
//  vkApp
//
//  Created by Денис Тереничев on 27.05.2022.
//

import UIKit

class NewsService {
    
    var imageCache = NSCache<NSString, UIImage>()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    ///Запрос информации о выбранном пользователе
    func loadNews(completion: @escaping (Result<ResponseClass, Error>) -> Void) {
        var urlForNewsFeedComponents = URLComponents()
        urlForNewsFeedComponents.scheme = "https"
        urlForNewsFeedComponents.host = "api.vk.com"
        urlForNewsFeedComponents.path = "/method/newsfeed.get"
        urlForNewsFeedComponents.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "source_ids", value: "friends"),
            URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlGetNews = urlForNewsFeedComponents.url else { return }
        print("URL GET NEWS = ", urlGetNews)
        session.dataTask(with: urlGetNews) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let newsFromJSON = try JSONDecoder().decode(NewsResponse.self, from: data).response
                DispatchQueue.main.async {
                    completion(.success(newsFromJSON))
                }
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(.failure(jsonError))
            }
        }.resume()
    }
    
    ///Запрос данных о  пользователе по его id
    func newsOwnerData(id: Int, completion: @escaping (Result<User, Error>) -> Void) {
        var urlGetNewsOwnerData = URLComponents()
        urlGetNewsOwnerData.scheme = "https"
        urlGetNewsOwnerData.host = "api.vk.com"
        urlGetNewsOwnerData.path = "/method/users.get"
        urlGetNewsOwnerData.queryItems = [
            URLQueryItem(name: "user_ids", value: "\(id)"),
            URLQueryItem(name: "fields", value: "photo_200_orig, online"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlGetOwnerData = urlGetNewsOwnerData.url
        else { return }
        print(urlGetOwnerData)
        session.dataTask(with: urlGetOwnerData) { (data, response, error) in
            if let error = error {
                print("some error")
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let ownerDataFromJSON = try JSONDecoder().decode(UserResponse.self, from: data).response[0]
                
                DispatchQueue.main.async {
                    completion(.success(ownerDataFromJSON))
                }
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(.failure(jsonError))
            }
        }.resume()
    }
}

extension NewsService {
    ///Загрузка изображения по URL и сохранение в кеш
    func imageLoader(url: URL?, completion: @escaping (UIImage) -> Void) {
        guard let url = url else {
            print("image url nil")
            return
        }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
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
