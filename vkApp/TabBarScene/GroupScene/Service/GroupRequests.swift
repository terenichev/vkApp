//
//  GroupRequests.swift
//  vkApp
//
//  Created by Денис Тереничев on 12.05.2022.
//

import Foundation
import RealmSwift

protocol GroupsRequestProtocol {
    func myGroupsRequest(url: URL, completion: @escaping (Result<[Group], Error>) -> Void)
}

class GroupsRequests: GroupsRequestProtocol {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    func myGroupsRequest(url: URL, completion: @escaping (Result<[Group], Error>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                
                do {
                    let groupsArrayFromJSON = try JSONDecoder().decode(SearchGroup.self, from: data).response.items
                    completion(.success(groupsArrayFromJSON))
                    
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
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
        print(urlGetSearchGroups)
        
        session.dataTask(with: urlGetSearchGroups) { (data, response, error) in
            
            if let error = error {
                print("some error")
                completion(.failure(error))
                return
            }
            DispatchQueue.main.async {
                guard let data = data else { return }
                
                do {
                    let groupsArrayFromJSON = try JSONDecoder().decode(SearchGroup.self, from: data).response.items
                    completion(.success(groupsArrayFromJSON))
                    
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
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
        print(urlGetSearchGroups)
        
        let task = session.dataTask(with: urlGetSearchGroups) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            guard let data = data else {
                return
            }
            do {
                let groupJoin = try JSONDecoder().decode(JoinOrLeaveGroupModel.self, from: data)
                completion(.success(groupJoin))
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(.failure(jsonError))
            }
        }
        task.resume()
    }

    
    func saveGroupsListData (_ groups: [Group]) {
        do {
            let config = Realm.Configuration( deleteRealmIfMigrationNeeded: true)
            let realm = try Realm(configuration: config)
            print("REALM URL = ", realm.configuration.fileURL ?? "error Realm URL")
            
            let oldGroups = realm.objects(Group.self)
            
            realm.beginWrite()
            realm.delete(oldGroups)
            realm.add(groups)
            try realm.commitWrite()
            
        } catch {
            print(error)
        }
    }
}
