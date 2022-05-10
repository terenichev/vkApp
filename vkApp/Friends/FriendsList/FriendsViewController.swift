//
//  FriendsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 18.02.2022.
//

import UIKit
import RealmSwift

class FriendsViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friends: [FriendsItem] {
        do {
            let realm = try Realm()
            let friend = realm.objects(FriendsItem.self)
            let friendsFromRealm = Array(friend)
            return friendsFromRealm
        } catch {
            print(error)
            return []
        }
    }
    
    var users: [FriendsItem]? = nil
    var userNames: [String] = []
    var friendImagesForShow: [UIImage?] = []
    
    var namesOfFriends: [String] = []
    var searchFriends: [FriendsItem]!
    
    var sortedFriends = [Character: [FriendsItem]]()
    
    var chars:[String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        self.sortedFriends = sort(friends: friends)
        self.tableView.reloadData()
    }
    
    private func sort(friends: [FriendsItem]) -> [Character: [FriendsItem]] {
        
        var friendsDict = [Character: [FriendsItem]]()
        
        friends.forEach() {friend in
            
            guard let firstChar = friend.firstName.first else {return}
           
            if var thisCharFriends = friendsDict[firstChar]{
                
                thisCharFriends.append(friend)
                friendsDict[firstChar] = thisCharFriends
                
            } else {
                friendsDict[firstChar] = [friend]
            }
        }
        
        return friendsDict
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return sortedFriends.keys.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let keySorted = sortedFriends.keys.sorted()

        let friends = sortedFriends[keySorted[section]]?.count ?? 0

        return friends
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendsCell else {
            preconditionFailure("FriendsCell cannot")
        }
        
        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        let friends = sortedFriends[firstChar]!
        
        let friend: FriendsItem = friends[indexPath.row]
        
        let url = URL(string: friend.avatarUrl)

            if let data = try? Data(contentsOf: url!)
            {
                cell.imageFriendsCell.image = UIImage(data: data)
            }
        
        cell.labelFriendsCell.text = friend.firstName + " " + friend.lastName

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return String(sortedFriends.keys.sorted()[section])
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileVC") as! profileViewController
        
        profileVC.transitioningDelegate = profileVC
        
        let keys = Array(sortedFriends.keys.sorted())
        let friendsInKey: [FriendsItem]
        var friendToShow: FriendsItem
        
        friendsInKey = sortedFriends[keys[indexPath.section]]!
        friendToShow = friendsInKey[indexPath.row]
        
        print("friendToShow ID = ",friendToShow.id)
        
        let request = Request()
        
        var urlComponentsGetPhotos = URLComponents()
        urlComponentsGetPhotos.scheme = "https"
        urlComponentsGetPhotos.host = "api.vk.com"
        urlComponentsGetPhotos.path = "/method/photos.get"
        urlComponentsGetPhotos.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(friendToShow.id)"),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let urlGetPhotos = urlComponentsGetPhotos.url
        else {
            print("guard return")
            return }
        
        request.usersPhotoRequest(url: urlGetPhotos) { [weak self] result in
            switch result {
                
            case .success(let array):
                var photoUrls: [String] = []
                
                array.map({ photoUrls.append($0.sizes.last!.url) })
                var friendImages: [UIImage?] = []
                
                for photo in 0..<photoUrls.count {
                    let url = URL(string:"\(photoUrls[photo])")
                    
                    
                    if let data = try? Data(contentsOf: url!)
                    {
                        friendImages.append(UIImage(data: data))
                    }
                    self?.friendImagesForShow = friendImages
                }
                
            
            case .failure(let error):
                print("error", error)
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            profileVC.profileForFriend = friendToShow
            profileVC.arrayImages = self.friendImagesForShow

            self.navigationController?.pushViewController(profileVC, animated: true)
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showFriendProfile",
           let destinationVC = segue.destination as? profileViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            let keys = Array(sortedFriends.keys.sorted())
            let friendsInKey: [FriendsItem]
            let friendToShow: FriendsItem
            
            friendsInKey = sortedFriends[keys[indexPath.section]]!
            friendToShow = friendsInKey[indexPath.row]
            
            destinationVC.profileForFriend = friendToShow
        }
    }
    
    
    // MARK: Search Bar Config
    
    //При нажатии на строку поиска скрываем navigationBar с анимацией
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    //Реализация поиска независимо от введенного регистра
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        searchFriends = []
        
        if searchText == "" {
            searchFriends = friends
        }
        else {
            for friend in friends {
                let name = friend.firstName + " " + friend.lastName
                if name.lowercased().contains(searchText.lowercased()) {
                    searchFriends.append(friend)
                }
            }
        }
        
        self.sortedFriends = sort(friends: searchFriends)
        self.tableView.reloadData()
    }
    
}
