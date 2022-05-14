//
//  PhotoCollectionViewCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 14.05.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showedPhoto: UIImageView!
    static let identifier = "PhotoCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with image: UIImage) {
        showedPhoto.image = image
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
    }
    
    
}
