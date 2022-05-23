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
    
    @objc var friendsRefreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }
    
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

    let realm = RealmCacheService()
    private var notificationToken: NotificationToken?
    private var friendRespons: Results<FriendsItem>? {
        realm.read(FriendsItem.self)
    }
    
    var friendImagesForShow: [UIImage?] = []
    
    var searchFriends: [FriendsItem]!
    
    var chars:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = friendsRefreshControl
        createNotificationToken()
        
        searchBar.delegate = self
        self.searchFriends = friends
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global(qos: .background).async {
            self.service.myFriendsRequest()
        }
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        print("refresh")
        sender.endRefreshing()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchFriends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendsCell else {
            preconditionFailure("FriendsCell cannot")
        }
        let friend: FriendsItem = self.searchFriends[indexPath.row]
        
        let url = URL(string: friend.avatarMiddleSizeUrl)
        cell.imageFriendsCell.image = UIImage(named: "not photo")
        DispatchQueue.global(qos: .default).async {
            let imageFromUrl = self.service.imageLoader(url: url)
                DispatchQueue.main.async {
                    cell.imageFriendsCell.image = imageFromUrl
                    cell.onlineIdentificator.alpha = CGFloat(integerLiteral: friend.isOnline)
                }
        }
        cell.labelFriendsCell.text = friend.firstName + " " + friend.lastName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileVC") as! ProfileViewController
        
        var friendToShow: FriendsItem
        
        friendToShow = self.searchFriends[indexPath.row]
        
        profileVC.profileForFriend = friendToShow
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    
    
// MARK: - Search Bar Config
    ///При нажатии на строку поиска скрываем navigationBar с анимацией
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
    
    ///Реализация поиска независимо от введенного регистра
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchFriends = []
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
        self.tableView.reloadData()
    }
}

// MARK: - Realm Notification Token
private extension FriendsViewController {
    func createNotificationToken() {
        notificationToken = friendRespons?.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial(let friendsData):
                print("notificationToken, friendsData = \(friendsData.count)")
                    self.tableView.reloadData()
            case .update(_,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                let deletionsIndexpath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexpath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexpath = modifications.map { IndexPath(row: $0, section: 0) }
                
                var friendsUpdate: [FriendsItem] {
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
                self.searchFriends = friendsUpdate
                
                DispatchQueue.main.async {
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: deletionsIndexpath, with: .none)
                    self.tableView.insertRows(at: insertionsIndexpath, with: .none)
                    self.tableView.reloadRows(at: modificationsIndexpath, with: .none)
                    self.tableView.endUpdates()
                }
            case .error(let error):
                print("\(error)")
            }
        }
    }
}
