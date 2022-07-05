//
//  BottomOfNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class BottomOfNewsCell: UITableViewCell {
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var repostsLabel: UILabel!
    @IBOutlet weak var likeControl: LikeControl!
    
    @IBOutlet weak var container: UIView!
    static let identifier = "BottomOfNewsCell"
    
    var newsItem: NewsItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        container.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ : UIGestureRecognizer){
        likeControl.islike.toggle()
        
        if likeControl.islike {
            likeControl.plusOneLike()
        } else {
            likeControl.minusOneLike()
        }
    }
    
    public func configure(with newsItem: NewsItem) {
        self.newsItem = newsItem
        print("bottom configure")
        if newsItem.likes?.userLikes == 1 {
            likeControl.plusOneLike()
        } else {
            likeControl.minusOneLike()
        }

        likeControl.likesCountLabel.text = String(describing: newsItem.likes?.count ?? 0)
        likeControl.likesCount = newsItem.likes?.count ?? 0
        commentsLabel.text = String(describing: newsItem.comments?.count ?? 0)
        repostsLabel.text = String(describing: newsItem.views?.count ?? 0)
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "BottomOfNewsCell", bundle: nil)
    }
}
