//
//  NewsTableViewCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 05.03.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageNews: UIImageView!
    @IBOutlet weak var nameFriendNews: UILabel!
    @IBOutlet weak var dateOfPostNews: UILabel!
    
    @IBOutlet weak var textInPost: UITextView!
    
    @IBOutlet weak var imageInPost: UIImageView!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var sharesCountLabel: UILabel!
    
    static let identifier = "NewsTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(with avatar: UIImage, name: String, date: String?, text: String?, imagePost: UIImage?, likesCount: Int, sharesCount: Int, commentsCount: Int) {
        avatarImageNews.image = avatar
        nameFriendNews.text = name
        dateOfPostNews.text = date
        textInPost.text = text
        imageInPost.image = imagePost
        likesCountLabel.text = String(likesCount)
        commentsCountLabel.text = String(commentsCount)
        sharesCountLabel.text = String(sharesCount)
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "NewsTableViewCell", bundle: nil)
    }
    
}
