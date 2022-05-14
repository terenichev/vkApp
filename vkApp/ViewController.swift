//
//  ViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 10.02.2022.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var firstCircle: UIImageView!
    @IBOutlet weak var secondCircle: UIImageView!
    @IBOutlet weak var thirdCircle: UIImageView!
    
    let friendsRequest = FriendsRequests()
    var friendsListFromJSON: [FriendsItem] = []
    
    let groupsRequest = GroupsRequests()
    var groupsListFromJSON: [Group] = []
    
    var vkFriends: [FriendsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circlesAnimate()
        friendsGet()
        groupsGet()
    }
    
    func circlesAnimate() {
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseInOut) {
            self.firstCircle.layer.position.x -= 100
            self.thirdCircle.layer.position.x += 100
            self.secondCircle.layer.position.y += 100
        } completion: { _ in
            
            let friendToRealm = FriendsRequests()
            friendToRealm.saveFriendsListData(self.friendsListFromJSON)
            
            let groupToRealm = GroupsRequests()
            groupToRealm.saveGroupsListData(self.groupsListFromJSON)
            
            self.performSegue(withIdentifier: "checkLog", sender: self)
        }
    }
}

extension ViewController {
    func friendsGet() {
        friendsRequest.myFriendsRequest(completion: { [weak self] result in
            switch result {
            case .success(let usersFromJSON):
                self?.friendsListFromJSON = usersFromJSON
            case .failure(let error):
                print("error", error)
            }
        })
    }
    
    func groupsGet() {
        groupsRequest.myGroupsRequest(completion: { [weak self] result in
            switch result {
            case .success(let groupsFromJSON):
                self?.groupsListFromJSON = groupsFromJSON
            case .failure(let error):
                print("error", error)
            }
        })
    }
}
    


