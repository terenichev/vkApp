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
    
    public func configure(with image: UIImage) {
        newsPhoto.image = image
        newsPhoto.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "PhotosInNewsCell", bundle: nil)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            newsPhoto.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            newsPhoto.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            newsPhoto.topAnchor.constraint(equalTo: contentView.topAnchor),
            newsPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
}
