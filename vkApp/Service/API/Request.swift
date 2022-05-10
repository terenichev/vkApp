//
//  Request.swift
//  vkApp
//
//  Created by Денис Тереничев on 05.05.2022.
//

import Foundation
import RealmSwift

protocol RequestProtocol {
    func myFriendsReqest(url: URL, completion: @escaping (Result<[FriendsItem?], Error>) -> Void)
    func usersInfoRequest(url: URL, completion: @escaping (Result<DTO.Response, Error>) -> Void)
    func usersPhotoRequest(url: URL, completion: @escaping (Result<[Item], Error>) -> Void)
}

class Request: RequestProtocol {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    func usersInfoRequest(url: URL, completion: @escaping (Result<DTO.Response, Error>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
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
    
    func myFriendsReqest(url: URL, completion: @escaping (Result<[FriendsItem?], Error>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                
                do {
                    let friendsArrayFromJSON = try JSONDecoder().decode(MyFriends.self, from: data).response.items
                    
                    completion(.success(friendsArrayFromJSON))
                    
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    func usersPhotoRequest(url: URL, completion: @escaping (Result<[Item], Error>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                
                do {
                    let photoResponceFromJSON = try JSONDecoder().decode(UserPhotoURLResponse.self, from: data).response.items
                    
                    completion(.success(photoResponceFromJSON))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    func saveFriendsListData (_ friend: FriendsItem) {
        do {
            let realm = try Realm()
            print("REALM URL = ", realm.configuration.fileURL ?? "error Realm URL")

            let oldUsers = realm.objects(FriendsItem.self).filter("id == %@", friend.id)

            realm.beginWrite()
            realm.delete(oldUsers)
            realm.add(friend)
            try realm.commitWrite()

        } catch {
            print(error)
        }
    }
}
