//
//  GroupsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 11.05.2022.
//

import UIKit
import RealmSwift

class GroupsViewController: UITableViewController, UISearchBarDelegate {
    
    var groups: [Group] {
        do {
            let realm = try Realm()
            let group = realm.objects(Group.self)
            let groupsFromRealm = Array(group)
            return groupsFromRealm
        } catch {
            print(error)
            return []
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        searchBar.delegate = self
        
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupsCell else {
            preconditionFailure("GroupsCell cannot")
        }
       
        let group: Group = groups[indexPath.row]
        
        
        let url = URL(string: group.photo50)

            if let data = try? Data(contentsOf: url!)
            {
                cell.groupImage.image = UIImage(data: data)
            }
        
        cell.groupNameLabel.text = group.name

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
//    
//        searchFriends = []
//        
//        if searchText == "" {
//            searchFriends = friends
//        }
//        else {
//            for friend in friends {
//                let name = friend.firstName + " " + friend.lastName
//                if name.lowercased().contains(searchText.lowercased()) {
//                    searchFriends.append(friend)
//                }
//            }
//        }
//        
//        self.sortedFriends = sort(friends: searchFriends)
//        self.tableView.reloadData()
    }
    
}
