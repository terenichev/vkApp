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
    
    let service =  NewsService()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with item: NewsItem) {
        newsPhoto.image = UIImage(named: "not photo")!
        service.imageLoader(url: URL(string: item.photoURL) ) { loadedImage in
            DispatchQueue.main.async {
                self.newsPhoto.image = loadedImage
            }
        }
        newsPhoto.translatesAutoresizingMaskIntoConstraints = false
        
       
    }
    
    static func nib() -> UINib{
       
        return UINib(nibName: "PhotosInNewsCell", bundle: nil)
    }
    
    private func setConstraints() {

        contentView.addSubview(view)

        let topConstraint = view.topAnchor.constraint(equalTo: contentView.topAnchor)

        NSLayoutConstraint.activate([
            topConstraint,
            contentView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//            newsPhoto.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            newsPhoto.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newsPhoto.leftAnchor.constraint(equalTo: view.leftAnchor),
            newsPhoto.rightAnchor.constraint(equalTo: view.rightAnchor),
            newsPhoto.topAnchor.constraint(equalTo: view.topAnchor)
            
        ])

//        topConstraint.priority = .init(999)
    }
    
    override func layoutSubviews() {
        setConstraints()
    }
}
