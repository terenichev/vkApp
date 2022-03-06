//
//  NewsTableViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 05.03.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {

    let posts:[Post] = [tonyPost, thorPost, strangePost]
    var NewsOfFriend: Friend = tonyStark
    let nums: [String] = ["first","second","third","fourth","fifth","sixth"]
    var ttt = "Единство предмета речи — это тема высказывания. Тема — это смысловое ядро текста, конденсированное и обобщённое содержание текста.Понятие «содержание высказывания» связано с категорией информативности речи и присуще только тексту. Оно сообщает читателю индивидуально-авторское понимание отношений между явлениями, их значимости во всех сферах придают ему смысловую цельность."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as! NewsTableViewCell
        
//        cell.configure(with: tonyStark.mainImage!, name: tonyStark.name, date: "5 min ago", text: "My \(nums[indexPath.row]) post!!", imagePost: tonyStark.images[indexPath.row])
        cell.imageInPost.layer.cornerRadius = 5
        cell.avatarImageNews.layer.cornerRadius = cell.avatarImageNews.bounds.height/2
        
        cell.configure(with: posts[indexPath.row].friend.mainImage!, name: posts[indexPath.row].friend.name, date: posts[indexPath.row].dateOfPost, text: posts[indexPath.row].textInPost, imagePost: posts[indexPath.row].friend.images[2], likesCount: posts[indexPath.row].likesCount, sharesCount: posts[indexPath.row].sharesCount, commentsCount: posts[indexPath.row].commentsCount)
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
