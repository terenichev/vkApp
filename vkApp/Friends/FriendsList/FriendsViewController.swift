//
//  FriendsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 18.02.2022.
//

import UIKit
import Foundation

class FriendsViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friends = [
        tonyStark,
        thor,
        vandaMaksimov,
        karolDenvers,
        steeve,
        strange,
        scott,
        tom,
        andrew,
        tobbie]
    
    
    var namesOfFriends: [String] = []
    var searchFriends: [Friend]!
    
    var sortedFriends = [Character: [Friend]]()
    
    var chars:[String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
 
        searchFriends = friends
        self.sortedFriends = sort(friends: friends)
        
        //namesOfFriends = friends.sorted(by: { $0.name < $1.name})
        
    }

    
    private func sort(friends: [Friend]) -> [Character: [Friend]] {
        
        var friendsDict = [Character: [Friend]]()
        
        friends.forEach() {friend in
            
            guard let firstChar = friend.name.first else {return}
           
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
        
        let friend: Friend = friends[indexPath.row]
        
        cell.labelFriendsCell.text = friend.name
        cell.imageFriendsCell.image = friend.mainImage
        cell.imageFriendsCell.layer.cornerRadius = 45

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return String(sortedFriends.keys.sorted()[section])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showFriendProfile",
           let destinationVC = segue.destination as? profileViewController,
           let indexPath = tableView.indexPathForSelectedRow {

                let keys = Array(sortedFriends.keys.sorted())
                let friendsInKey: [Friend]
                let friendToShow: Friend

                friendsInKey = sortedFriends[keys[indexPath.section]] ?? [tonyStark]
                friendToShow = friendsInKey[indexPath.row]

                destinationVC.profileForFriend = friendToShow
                destinationVC.arrayImages = friendToShow.images
        }
    }
    
    
    // MARK: Search Bar Config
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFriends = []
        
        if searchText == "" {
            searchFriends = friends
        }
        else {
            for friend in friends {
                
                if friends.contains(where: {$0.name.lowercased().contains(searchText.lowercased())}) {
                    self.searchFriends.append(friend)
                    print(searchFriends ?? "nil")
                } else {
                    print("nonono")
                }
                
            }
        }
        
                    
        self.tableView.reloadData()
       // print("relosd data")
        
    }
}
