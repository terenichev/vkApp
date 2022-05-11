//
//  AllGroupsVC.swift
//  vkApp
//
//  Created by Денис Тереничев on 24.02.2022.
//

import UIKit

class AllGroupsVC: UITableViewController {

//    var allGroups = [
//        thanosGroup,
//        betGroup,
//        darkholdGroup,
//        audiGroup,
//        venomGroup,
//        visionGroup,
//        civilWarGroup,
//        infinityWarGroup,
//        igmGroup,
//        altronGroup
//    ]
    
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
//        return allGroups.count
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "allGroupsCell", for: indexPath) as? UITableViewCell else {
            preconditionFailure("GroupsCell cannot")
        }
//
//        var content = cell.defaultContentConfiguration()
//
//        content.text = allGroups[indexPath.row].name
//        content.image = allGroups[indexPath.row].image
//
//        content.imageProperties.maximumSize = CGSize(width: 45, height: 45)
//        content.imageProperties.cornerRadius = 50
//        content.textProperties.font = UIFont(name: "Kefa", size: 17)!
//        content.imageToTextPadding = CGFloat(20)
//
//        cell.contentConfiguration = content
    
        return cell
    }
}
