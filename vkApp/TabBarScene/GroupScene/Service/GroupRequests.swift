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
