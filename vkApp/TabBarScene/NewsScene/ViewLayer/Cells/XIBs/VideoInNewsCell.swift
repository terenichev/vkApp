//
//  VideoInNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 06.06.2022.
//

import UIKit

class VideoInNewsCell: UITableViewCell {
    @IBOutlet weak var videoPhoto: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(with image: UIImage, height: Int?, width: Int?) {
        videoPhoto.image = image
        videoPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            videoPhoto.heightAnchor.constraint(equalToConstant: (contentView.bounds.width / CGFloat(width ?? 100)) * CGFloat(height ?? 100)),
            videoPhoto.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            videoPhoto.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            videoPhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            videoPhoto.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
