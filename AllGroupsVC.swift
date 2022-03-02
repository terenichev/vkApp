//
//  AllGroupsVC.swift
//  vkApp
//
//  Created by Денис Тереничев on 24.02.2022.
//

import UIKit

class AllGroupsVC: UITableViewController {

    var allGroups = [
        thanosGroup,
        betGroup,
        darkholdGroup,
        audiGroup,
        venomGroup,
        visionGroup,
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "allGroupsCell", for: indexPath) as? AllGroupsCell else {
            preconditionFailure("GroupsCell cannot")
        }
        
        var content = cell.defaultContentConfiguration()
        
        content.text = allGroups[indexPath.row].name
        content.image = allGroups[indexPath.row].image
        
        content.imageProperties.maximumSize = CGSize(width: 45, height: 45)
        content.imageProperties.cornerRadius = 50
        content.textProperties.font = UIFont(name: "Kefa", size: 17)!
        content.imageToTextPadding = CGFloat(20)
        
        cell.contentConfiguration = content
    
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
