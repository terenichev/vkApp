//
//  LikeControl.swift
//  vkApp
//
//  Created by Денис Тереничев on 27.06.2022.
//

import UIKit

class LikeControl: UIControl {

    @IBOutlet var likePicture: UIImageView!
    @IBOutlet var likesCountLabel: UILabel!
    
    var newsItem: NewsItem?
    var islike: Bool = false
    var likesCount = 0
    
    func plusOneLike() {
        UIView.animate(withDuration: 0.5, delay: 0,
        usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],
        animations: {
            self.likePicture.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
            self.likePicture.tintColor = .red
            self.likesCountLabel.textColor = .red
            self.likesCount += 1
            self.likesCountLabel.text = String(self.likesCount)
        })
    
        UIView.animate(withDuration: 0.5, delay: 0.2,
        usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],
        animations: {
            self.likePicture.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func minusOneLike() {
        likePicture.tintColor = .systemBlue
        likesCountLabel.textColor = .black
        likesCount -= 1
        likesCountLabel.text = String(likesCount)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("control awake")
        likesCountLabel.tintColor = .black
        likePicture.tintColor = .systemBlue
        likesCountLabel.text = String(likesCount)
    }
}
