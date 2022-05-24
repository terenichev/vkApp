//
//  FriendsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 18.02.2022.
//

import UIKit

class FriendsViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @objc var friendsRefreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
//        refreshControl.attributedTitle = NSAttributedString(string: "text")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }
    
    let service = FriendsRequests()
    
    var friends: [FriendsItem] = []
    
    var searchFriends: [FriendsItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = friendsRefreshControl
        
        searchBar.delegate = self
        self.searchFriends = friends
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        DispatchQueue.global(qos: .background).async {
            self.loadFriends()
        }
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        DispatchQueue.global(qos: .background).async {
            self.loadFriends()
        }
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

// MARK: - Load Friends
private extension FriendsViewController {
    ///Загружаем список друзей и сохраняем в массив
    func loadFriends() {
        service.loadFriendsList { [weak self] result in
            switch result {
            case .success(let friends):
                self?.friends = friends
                self?.searchFriends = friends
                DispatchQueue.main.async {
                    // перезагрузим данные
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}
