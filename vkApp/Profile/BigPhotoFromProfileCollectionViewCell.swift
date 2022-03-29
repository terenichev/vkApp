//
//  BigPhotoFromProfileCollectionViewCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 09.03.2022.
//

import UIKit

class BigPhotoFromProfileCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bigImage: UIImageView!
    
    
    static let identifier = "bigPhotoCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with image: UIImage) {
        bigImage.image = image
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "BigPhotoFromProfileCollectionViewCell", bundle: nil)
    }

}
