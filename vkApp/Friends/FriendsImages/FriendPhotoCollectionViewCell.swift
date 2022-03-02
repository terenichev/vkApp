//
//  FriendPhotoCollectionViewCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 23.02.2022.
//

import UIKit

class FriendPhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagesOfFriend: UIImageView!
    @IBOutlet var likeControl: LikeControl!
    @IBOutlet var container: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        container.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ : UIGestureRecognizer){
        likeControl.islike.toggle()
        
        if likeControl.islike {
            likeControl.likePicture.tintColor = .red
            likeControl.likesCountLabel.textColor = .red
            likeControl.likesCount += 1
            likeControl.likesCountLabel.text = String(likeControl.likesCount)
        } else {
            likeControl.likePicture.tintColor = .lightGray
            likeControl.likesCountLabel.textColor = .lightGray
            likeControl.likesCount -= 1
            likeControl.likesCountLabel.text = String(likeControl.likesCount)
        }
    }
}
