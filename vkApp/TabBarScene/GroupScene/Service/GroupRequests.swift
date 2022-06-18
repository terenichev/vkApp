//
//  GroupRequests.swift
//  vkApp
//
//  Created by Денис Тереничев on 12.05.2022.
//

import UIKit

class GroupsRequests {
    var imageCache = NSCache<NSString, UIImage>()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    ///Запрос списка групп текущего пользователя
    func loadGroupsList(_ completion: @escaping (Result<[Group], Error>) -> Void) {
        var urlForGroupComponents = URLComponents()
        urlForGroupComponents.scheme = "https"
        urlForGroupComponents.host = "api.vk.com"
        urlForGroupComponents.path = "/method/groups.get"
        urlForGroupComponents.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlGetGroups = urlForGroupComponents.url else { return }
        session.dataTask(with: urlGetGroups) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let groupsArrayFromJSON = try JSONDecoder().decode(SearchGroup.self, from: data).response.items
                DispatchQueue.main.async {
                    completion(.success(groupsArrayFromJSON))
                }
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(.failure(jsonError))
            }
        }.resume()
    }
    ///Поиск группы по введенным символам
    func searchGroupsRequest(searchText: String, completion: @escaping (Result<[Group], Error>) -> Void) {
        var urlForGroupSearchComponents = URLComponents()
        urlForGroupSearchComponents.scheme = "https"
        urlForGroupSearchComponents.host = "api.vk.com"
        urlForGroupSearchComponents.path = "/method/groups.search"
        urlForGroupSearchComponents.queryItems = [
            URLQueryItem(name: "q", value: searchText),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "40"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlGetSearchGroups = urlForGroupSearchComponents.url else { return }
        session.dataTask(with: urlGetSearchGroups) { (data, response, error) in
            if let error = error {
                print("some error")
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let groupsArrayFromJSON = try JSONDecoder().decode(SearchGroup.self, from: data).response.items
                DispatchQueue.main.async {
                    completion(.success(groupsArrayFromJSON))
                }
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(.failure(jsonError))
            }
        }.resume()
    }
    ///Добавление группы по id в список групп текущего пользователя
    func addGroup(idGroup: Int,
                  completion: @escaping(Result<JoinOrLeaveGroupModel, Error>) -> Void) {
        var urlForAddGroupComponents = URLComponents()
        urlForAddGroupComponents.scheme = "https"
        urlForAddGroupComponents.host = "api.vk.com"
        urlForAddGroupComponents.path = "/method/groups.join"
        urlForAddGroupComponents.queryItems = [
            URLQueryItem(name: "group_id", value: "\(idGroup)"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlGetSearchGroups = urlForAddGroupComponents.url else { return }
        let task = session.dataTask(with: urlGetSearchGroups) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let data = data else {
                return
            }
            do {
                let groupJoin = try JSONDecoder().decode(JoinOrLeaveGroupModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(groupJoin))
                }
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }
}

extension GroupsRequests {
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
