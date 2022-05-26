//
//  NewsViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class NewsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(OwnerNewsCell.nib(), forCellReuseIdentifier: OwnerNewsCell.identifier)
        tableView.register(TextInNewsCell.nib(), forCellReuseIdentifier: TextInNewsCell.identifier)
        tableView.register(PhotosInNewsCell.nib(), forCellReuseIdentifier: PhotosInNewsCell.identifier)
        tableView.register(BottomOfNewsCell.nib(), forCellReuseIdentifier: BottomOfNewsCell.identifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OwnerNewsCell", for: indexPath) as? OwnerNewsCell else { preconditionFailure("OwnerNewsCell cannot") }
            
            cell.configure(with: UIImage(named: "not photo")!, name: "Иван Иванов", dateOfNews: "28 минут назад")
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextInNewsCell.identifier, for: indexPath) as? TextInNewsCell else { preconditionFailure("TextInNewsCell cannot") }
            cell.configure(with: "text in post")
            return cell
        } else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosInNewsCell.identifier, for: indexPath) as? PhotosInNewsCell else { preconditionFailure("PhotosInNewsCell cannot") }
            cell.configure(with: UIImage(named: "not photo")!)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BottomOfNewsCell.identifier, for: indexPath) as? BottomOfNewsCell else { preconditionFailure("BottomOfNewsCell cannot") }
            cell.configure(with: "5", comments: "6", reposts: "7")
            return cell
        }
        
        
    }
    
}
