//
//  LikeControl.swift
//  vkApp
//
//  Created by Денис Тереничев on 26.02.2022.
//

import UIKit

class LikeControl: UIControl {

    @IBOutlet var likePicture: UIImageView!
    @IBOutlet var likesCountLabel: UILabel!
    
    var islike: Bool = false
    var likesCount = 7
    
    func plusOneLike() {
        
        UIView.animate(withDuration: 0.5, delay: 0,
        usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],
        animations: {
            
            self.likePicture.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
//            self.likesCountLabel.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
            self.likePicture.tintColor = .red
            self.likesCountLabel.textColor = .red
            self.likesCount += 1
            self.likesCountLabel.text = String(self.likesCount)
        })
    
        UIView.animate(withDuration: 0.5, delay: 0.2,
        usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],
        animations: {
            
            self.likePicture.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.likesCountLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        
    }
    
    func minusOneLike() {
        likePicture.tintColor = .lightGray
        likesCountLabel.textColor = .lightGray
        likesCount -= 1
        likesCountLabel.text = String(likesCount)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likesCountLabel.tintColor = .lightGray
        likePicture.tintColor = .lightGray
        likesCountLabel.text = String(likesCount)
    }

}
