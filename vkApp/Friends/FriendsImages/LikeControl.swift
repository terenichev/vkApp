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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likesCountLabel.tintColor = .lightGray
        likePicture.tintColor = .lightGray
        likesCountLabel.text = String(likesCount)
        
    }

}
