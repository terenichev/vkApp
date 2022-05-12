//
//  GroupPhotoView.swift
//  vkApp
//
//  Created by Денис Тереничев on 12.05.2022.
//

import UIKit

class GroupPhotoView: UIView {

    @IBOutlet var groupImage: UIImageView!
    @IBOutlet var shadowView: UIView!
    
    var shadowColor = UIColor.black
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 2)
        shadowView.layer.shadowRadius = 2
        shadowView.layer.shadowOpacity = 0.7
    }
    
    override func layoutSubviews() {
        groupImage.layer.cornerRadius = bounds.height/2
        shadowView.layer.cornerRadius = bounds.height/2
        self.layer.cornerRadius = bounds.height/2
    }
}
