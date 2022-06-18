//
//  ProfilePhotosViewCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 01.03.2022.
//

import UIKit

class UserPhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = "ProfilePhotosCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(with image: UIImage) {
        imageView.image = image
        imageView.layer.cornerRadius = 5
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "ProfilePhotosCollectionViewCell", bundle: nil)
    }
}
