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
    func loadNews(completion: @escaping (Result<[NewsItem], Error>) -> Void) {
        var urlForNewsFeedComponents = URLComponents()
        urlForNewsFeedComponents.scheme = "https"
        urlForNewsFeedComponents.host = "api.vk.com"
        urlForNewsFeedComponents.path = "/method/newsfeed.get"
        urlForNewsFeedComponents.queryItems = [
            URLQueryItem(name: "filters", value: "photos"),
            URLQueryItem(name: "source_ids", value: "friends"),
            URLQueryItem(name: "count", value: "20"),
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
                let newsFromJSON = try JSONDecoder().decode(NewsResponse.self, from: data).response.items
                DispatchQueue.main.async {
                    completion(.success(newsFromJSON))
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

extension NewsService {
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
