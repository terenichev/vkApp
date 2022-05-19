//
//  BottomOfNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class BottomOfNewsCell: UITableViewCell {
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var repostsLabel: UILabel!
    
    static let identifier = "BottomOfNewsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with likes: String, comments: String, reposts: String) {
        likesLabel.text = likes
        commentsLabel.text = comments
        repostsLabel.text = reposts
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "BottomOfNewsCell", bundle: nil)
    }
    
}
