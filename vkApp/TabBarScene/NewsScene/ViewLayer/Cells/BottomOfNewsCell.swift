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
    
    public func configure(with likes: String, comments: String, reposts: String) {
        likeControl.likesCountLabel.text = likes
        likeControl.likesCount = Int(likes) ?? 0
        commentsLabel.text = comments
        repostsLabel.text = reposts
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "BottomOfNewsCell", bundle: nil)
    }
    
}
