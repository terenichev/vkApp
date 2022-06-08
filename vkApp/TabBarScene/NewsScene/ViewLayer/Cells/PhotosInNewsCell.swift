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
    
    func configure(with image: UIImage, height: Int?, width: Int?) {
        newsPhoto.image = image
        newsPhoto.translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    static func nib() -> UINib{
       
        return UINib(nibName: "PhotosInNewsCell", bundle: nil)
    }
    
    private func setConstraints() {

        contentView.addSubview(newsPhoto)

        let topConstraint = newsPhoto.topAnchor.constraint(equalTo: contentView.topAnchor)

        NSLayoutConstraint.activate([
            topConstraint,
            newsPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            newsPhoto.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            newsPhoto.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            newsPhoto.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: newsPhoto.heightAnchor)
        ])

        topConstraint.priority = .init(999)
    }

    
}
