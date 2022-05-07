//
//  SecondHomeworkVC.swift
//  vkApp
//
//  Created by Денис Тереничев on 01.05.2022.
//

import UIKit



class SecondHomeworkVC: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var myFriendsListRequest: UIButton!
    @IBOutlet weak var myPhotosRequest: UIButton!
    @IBOutlet weak var meGroupsRequest: UIButton!
    
    @IBOutlet weak var searchGroupsTextField: UITextField!
    @IBOutlet weak var groupsSearchBar: UISearchBar!
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    var request = Request()
    
    var usersArray:[Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsSearchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchBar.text!)
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "\(searchBar.text!)"),
            URLQueryItem(name: "count", value: "2"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        print(String(decoding: data!, as: UTF8.self))
            print(error ?? "")
        }
        task.resume()
    }
    
    @IBAction func getFriendsList(_ sender: UIButton) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "order", value: "hints"),
//            URLQueryItem(name: "fields", value: "photo_200_orig"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = urlComponents.url else { return }
        
        print(url)
        
//        request(url: url) { result in
//            switch result {
//                
//            case .success(let usersFromJSON):
//                print(usersFromJSON)
//                self.usersArray = usersFromJSON
//                usersFromJSON.map({ (ids) in
//                    print("id =", ids)
//                })
//            case .failure(let error):
//                print("error", error)
//            }
//        }

    }
    
    @IBAction func getMyPhotos(_ sender: UIButton) {
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/photos.get"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "album_id", value: "profile"),
//            URLQueryItem(name: "count", value: "2"),
//            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
//            URLQueryItem(name: "v", value: "5.131")
//        ]
//
//        guard let url = urlComponents.url else { return }
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        print(String(decoding: data!, as: UTF8.self))
//            print(error ?? "")
//        }
//        task.resume()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/users.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_ids", value: "\(self.usersArray)"),
            URLQueryItem(name: "fields", value: "status , photo_max_orig"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = urlComponents.url else { return }
        print(url)
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        print(String(decoding: data!, as: UTF8.self))
//            print(error ?? "")
//        }
//        task.resume()
        request.usersInfoRequest(url: url) { result in
            switch result {
            case .success(let users):
                print(users.response[0].firstName)
            case .failure(let error):
                print("error", error)
            }
        }
    }
    
    @IBAction func getMyGroups(_ sender: UIButton) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
//            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "count", value: "2"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]

        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        print(String(decoding: data!, as: UTF8.self))
            print(error ?? "")
        }
        task.resume()
        
    }
    
    
    
    @IBAction func searchGroups(_ sender: UITextField) {
        
    }
    
    func request(url: URL, completion: @escaping(Result<Int, Error>) -> Void) {
        session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                
                do {
                    let usersIdsArrayFromJSON = try JSONDecoder().decode(MyFriends.self, from: data).response.items.count
                    
                    completion(.success(usersIdsArrayFromJSON))
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
}



