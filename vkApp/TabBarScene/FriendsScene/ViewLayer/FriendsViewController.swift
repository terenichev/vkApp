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
    
    let service = FriendsRequests()
    
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
        cell.imageFriendsCell.image = UIImage(named: "not photo")
        DispatchQueue.global(qos: .utility).async {
            let imageFromUrl = self.service.imageLoader(url: url)
                DispatchQueue.main.async {
                    cell.imageFriendsCell.image = imageFromUrl
                }
        }
        cell.labelFriendsCell.text = friend.firstName + " " + friend.lastName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(sortedFriends.keys.sorted()[section])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
        
        let keys = Array(sortedFriends.keys.sorted())
        let friendsInKey: [FriendsItem]
        var friendToShow: FriendsItem
        
        friendsInKey = sortedFriends[keys[indexPath.section]]!
        friendToShow = friendsInKey[indexPath.row]
        
        profileVC.profileForFriend = friendToShow
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    // MARK: - Search Bar Config
    
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

// MARK: - Private
private extension FriendsViewController {
    func sort(friends: [FriendsItem]) -> [Character: [FriendsItem]] {
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
}
