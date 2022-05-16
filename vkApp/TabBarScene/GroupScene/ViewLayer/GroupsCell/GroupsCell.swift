//
//  GroupsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 11.05.2022.
//

import UIKit

class GroupsCell: UITableViewCell{
    
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    var id: Int?
    var name: String?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
