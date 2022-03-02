//
//  FriendsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 18.02.2022.
//

import UIKit

class FriendsViewController: UITableViewController {

    
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
    
//    let callToFriend = FriendCall(mainImage: UIImage.init(systemName: "homepod.2"))

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath) as? FriendsCell else {
            preconditionFailure("FriendsCell cannot")
        }
        
        cell.labelFriendsCell.text = friends[indexPath.row].name
        cell.imageFriendsCell.image = friends[indexPath.row].mainImage
        cell.imageFriendsCell.layer.cornerRadius = 45

//        var content = cell.defaultContentConfiguration()
//        content.text = friends[indexPath.row].name
//        content.image = friends[indexPath.row].mainImage
//
//
//        content.imageProperties.maximumSize = CGSize(width: 45, height: 45)
////        content.imageProperties.cornerRadius = 50
//        content.textProperties.font = UIFont(name: "Kefa", size: 17)!
//        content.imageToTextPadding = CGFloat(20)
//
//        cell.contentConfiguration = content

        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "showFriendsPhoto",
//           let destinationVC = segue.destination as? FriendPhotosCollectionVC,
//           let indexPath = tableView.indexPathForSelectedRow {
//
//            let friendToShow = friends[indexPath.row].name
//            destinationVC.title = friendToShow
//            destinationVC.arrayImages = friends[indexPath.row].images
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showFriendProfile",
           let destinationVC = segue.destination as? profileViewController,
           let indexPath = tableView.indexPathForSelectedRow {

//            let friendToShow = friends[indexPath.row].name
            //destinationVC.title = friendToShow
            destinationVC.arrayImages = friends[indexPath.row].images
        }
        
    }
}
