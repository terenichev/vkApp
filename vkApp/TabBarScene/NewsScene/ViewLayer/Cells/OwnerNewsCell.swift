//
//  OwnerNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class OwnerNewsCell: UITableViewCell {
    
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var publicationTime: UILabel!
    
    static let identifier = "OwnerNewsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with image: UIImage, name: String, dateOfNews: String) {
        ownerImage.image = image
        ownerImage.layer.cornerRadius = ownerImage.bounds.height/2
        ownerName.text = name
        publicationTime.text = dateOfNews
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "OwnerNewsCell", bundle: nil)
    }
    
}
