//
//  GroupsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 21.02.2022.
//

import UIKit

class FavoriteGroupsViewController: UITableViewController {

    var myGroups = [
        thanosGroup,
//        visionGroup,
        darkholdGroup,
        audiGroup,
        venomGroup,
        betGroup,
        civilWarGroup,
        infinityWarGroup,
        igmGroup,
        altronGroup
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return myGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? FavoriteGroupsCell else {
            preconditionFailure("GroupsCell cannot")
        }
        
        var content = cell.defaultContentConfiguration()
        
        content.text = myGroups[indexPath.row].name
        content.image = myGroups[indexPath.row].image
        
        content.imageProperties.maximumSize = CGSize(width: 45, height: 45)
        content.imageProperties.cornerRadius = 50
        content.textProperties.font = UIFont(name: "Kefa", size: 17)!
        content.imageToTextPadding = CGFloat(20)
        
        cell.contentConfiguration = content
    
        return cell
    }
    
    @IBAction func addSelectedGroup(segue: UIStoryboardSegue){
        if let sourceVC = segue.source as? AllGroupsVC,
           let indexPath = sourceVC.tableView.indexPathForSelectedRow{
            
            let group = sourceVC.allGroups[indexPath.row]
            
            if !myGroups.contains(where: {$0.name == group.name}) {
                
            myGroups.append(group)
            tableView.reloadData()
                
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            myGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
   
}
