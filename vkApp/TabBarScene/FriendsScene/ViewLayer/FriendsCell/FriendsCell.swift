//
//  FriendsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 18.02.2022.
//

import UIKit

class FriendsCell: UITableViewCell{
    
    @IBOutlet weak var imageFriendsCell: UIImageView!
    
    @IBOutlet weak var labelFriendsCell: UILabel!
    
    @IBOutlet weak var callToFriend: UIImageView!
    
    @IBOutlet weak var onlineIdentificator: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        onlineIdentificator.layer.cornerRadius = 5
        imageFriendsCell.layer.cornerRadius = bounds.height/2
    }
    

}
