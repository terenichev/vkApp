//
//  PhotosInNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class PhotosInNewsCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var newsPhoto: UIImageView!
    
    static let identifier = "PhotosInNewsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with image: UIImage, height: Int?, width: Int?) {
        newsPhoto.image = image
        var scale = contentView.bounds.width / CGFloat(width!)
        let constraintConstant: CGFloat?
        if scale <= 1 {
            constraintConstant = (contentView.bounds.width / CGFloat(width!)) * CGFloat(height!)
        }
        newsPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsPhoto.heightAnchor.constraint(equalToConstant: (contentView.bounds.width / CGFloat(width!)) * CGFloat(height!)),
            newsPhoto.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            newsPhoto.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            newsPhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            newsPhoto.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        
        
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "PhotosInNewsCell", bundle: nil)
    }
    
}
