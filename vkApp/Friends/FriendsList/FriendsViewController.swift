//
//  FriendsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 18.02.2022.
//

import UIKit

class FriendsViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friends = Singleton.instance.friends ?? [tonyStark]
    
    
    var users: [Friend]? = nil
    var userNames: [String] = []
    
    var namesOfFriends: [String] = []
    var searchFriends: [Friend]!
    
    var sortedFriends = [Character: [Friend]]()
    
    var chars:[String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        

        self.sortedFriends = sort(friends: friends)
        self.tableView.reloadData()
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
        
//        print(users)
//        self.tableView.reloadData()

        

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return String(sortedFriends.keys.sorted()[section])
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profileVC") as! profileViewController
        
        profileVC.transitioningDelegate = profileVC
        
        let keys = Array(sortedFriends.keys.sorted())
        let friendsInKey: [Friend]
        var friendToShow: Friend
        
        friendsInKey = sortedFriends[keys[indexPath.section]] ?? [tonyStark]
        friendToShow = friendsInKey[indexPath.row]
        
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
                print("urlGetPhotos:",urlGetPhotos)
        
        request.usersPhotoRequest(url: urlGetPhotos) { [weak self] result in
            switch result {
                
            case .success(let array):
                //                print("ARRAY of Items = ", array)
                var photoUrls: [String] = []
                
                array.map({ photoUrls.append($0.sizes.last!.url) })
                
                for photo in 0..<photoUrls.count {
                    let url = URL(string:"\(photoUrls[photo])")
                    
                    if let data = try? Data(contentsOf: url!)
                    {
                        friendToShow.images.append(UIImage(data: data))
                    }
                }
                
                //                print("arraySizes = ", photoUrls)
            case .failure(let error):
                print("error", error)
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            profileVC.profileForFriend = friendToShow
            profileVC.arrayImages = friendToShow.images
            
            print("SHOW PROFILE")
            
            //        self.present(friendsImageAnimatingVC, animated: true, completion: nil)
            
            self.navigationController?.pushViewController(profileVC, animated: true)
        })
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
                if friend.name.lowercased().contains(searchText.lowercased()) {
                    searchFriends.append(friend)
                }
            }
        }
        
        self.sortedFriends = sort(friends: searchFriends)
        self.tableView.reloadData()
    }
    
}
