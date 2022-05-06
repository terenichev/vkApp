//
//  FriendsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 18.02.2022.
//

import UIKit

class FriendsViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friends = [tonyStark, thor]
    
<<<<<<< HEAD
    let request = Request()
    var usersIds: [Int] = []
    var myUsers: DTO.Response? = nil
    
    var users: [Friend]? = nil
    var userNames: [String] = []
=======
    var a = 1
    var users: User? = nil
>>>>>>> parent of 05ddf24 (hw 3 in process)
    
    var namesOfFriends: [String] = []
    var searchFriends: [Friend]!
    
    var sortedFriends = [Character: [Friend]]()
    
    var chars:[String] = []

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.viewDidLoad()
        searchBar.delegate = self
        self.sortedFriends = sort(friends: friends)
        
        friendsGetRequest()
        print(#function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchBar.delegate = self
//        self.sortedFriends = sort(friends: friends)
//
//        friendsGetRequest()
        
        print(#function)
            self.tableView.reloadData()
            print(self.friends)
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

        return friends - 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendsCell else {
            preconditionFailure("FriendsCell cannot")
        }
        
        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        let friends = sortedFriends[firstChar]!
        
        let friend: Friend = friends[indexPath.row]
        
//        cell.labelFriendsCell.text = friend.name
        cell.labelFriendsCell.text = users?.response[0].firstName
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
             let friendToShow: Friend

             friendsInKey = sortedFriends[keys[indexPath.section]] ?? [tonyStark]
             friendToShow = friendsInKey[indexPath.row]
             profileVC.profileForFriend = friendToShow
             profileVC.arrayImages = friendToShow.images
        
//        self.present(friendsImageAnimatingVC, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(profileVC, animated: true)
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
    
    
    // MARK: - Request
    
    func friendsGetRequest() {
        
        
        var urlForUserIdsComponents = URLComponents()
        urlForUserIdsComponents.scheme = "https"
        urlForUserIdsComponents.host = "api.vk.com"
        urlForUserIdsComponents.path = "/method/friends.get"
        urlForUserIdsComponents.queryItems = [
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "order", value: "hints"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let urlGetIds = urlForUserIdsComponents.url else { return }
        print(urlGetIds)
        
            self.request.usersIdsRequest(url: urlGetIds, completion: { result in
            switch result {
            case .success(let usersFromJSON):
                self.usersIds = usersFromJSON
                print("usersIds = ", self.usersIds)
            case .failure(let error):
                print("error", error)
            }
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)) {
        var urlComponentsForUserInfo = URLComponents()
        urlComponentsForUserInfo.scheme = "https"
        urlComponentsForUserInfo.host = "api.vk.com"
        urlComponentsForUserInfo.path = "/method/users.get"
        urlComponentsForUserInfo.queryItems = [
            URLQueryItem(name: "user_ids", value: "\(self.usersIds)"),
            URLQueryItem(name: "fields", value: "status,photo_max_orig"),
            URLQueryItem(name: "access_token", value: "\(Singleton.instance.token!)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
            guard let urlGetUsers = urlComponentsForUserInfo.url else { return }
            print("urlGetUsers:",urlGetUsers)
            self.request.usersInfoRequest(url: urlGetUsers) { result in
                switch result {
                case .success(let users):
                    self.myUsers = users
                    print("myUsers 1 = ", self.myUsers)
                case .failure(let error):
                    print("error", error)
                }
            }
        
        }
       
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0)) {
            
            print("After 5 seconds")
            
            
            
            print("myUsers 2 = ", self.myUsers)
            guard let array = self.myUsers
            else {
                print("guard return")
                return }
            //        print("MY USERS = ", array)
            //        print("myUsers?.response.count = ", array.response.count)
            //        print("myUsers!.response[0] = ",array.response[0])
            
            let arrayOfUsers = array.response
            for user in 0 ... arrayOfUsers.count - 1 {
                let url = URL(string:"\(arrayOfUsers[user].photoMaxOrig)")
//                print(url!)
                if let data = try? Data(contentsOf: url!)
                {
                    var friend: Friend =  Friend.init(mainImage: UIImage(data: data), name: arrayOfUsers[user].firstName + " " + arrayOfUsers[user].lastName, images: [tonyStark.mainImage], statusText: arrayOfUsers[user].status ?? "")
                    self.friends.append(friend)
                }
            }
            print("VKFRIENDS = ",self.friends)
            
            self.tableView.reloadData()
        }
            
            
        
        
    
}
    
}
