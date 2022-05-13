//
//  vandaViewCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 01.03.2022.
//

import UIKit

class ProfilePhotosViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    
    static let identifier = "profilePhotosViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(with image: UIImage) {
        imageView.image = image
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "profilePhotosViewCell", bundle: nil)
    }
}
