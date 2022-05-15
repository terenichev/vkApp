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
        
        DispatchQueue.global(qos: .utility).async {
            self.friendsRequest.myFriendsRequest()
            self.groupsRequest.myGroupsRequest()
        }
        circlesAnimate()
    }
    
    func circlesAnimate() {
        UIView.animate(withDuration: 1,
                       delay: 0,
                       options: .curveEaseInOut) {
            self.firstCircle.layer.position.x -= 100
            self.thirdCircle.layer.position.x += 100
            self.secondCircle.layer.position.y += 100
        } completion: { _ in
            self.performSegue(withIdentifier: "checkLog", sender: self)
        }
    }
}



