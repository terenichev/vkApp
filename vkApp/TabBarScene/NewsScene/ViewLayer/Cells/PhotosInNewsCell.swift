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
    
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< Updated upstream
    func configure(with item: NewsItem) {
        newsPhoto.image = UIImage(named: "not photo")!
        service.imageLoader(url: URL(string: item.photoURL) ) { loadedImage in
            DispatchQueue.main.async {
                self.newsPhoto.image = loadedImage
            }
        }
=======
    func configure(with image: UIImage) {
        newsPhoto.image = image
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
            contentView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//            newsPhoto.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            newsPhoto.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newsPhoto.leftAnchor.constraint(equalTo: view.leftAnchor),
            newsPhoto.rightAnchor.constraint(equalTo: view.rightAnchor),
            newsPhoto.topAnchor.constraint(equalTo: view.topAnchor)
            
=======
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            view.heightAnchor.constraint(equalTo: contentView.widthAnchor),
//            contentView.heightAnchor.constraint(equalTo: view.heightAnchor)
>>>>>>> Stashed changes
        ])

//        topConstraint.priority = .init(999)
=======
    public func configure(with image: UIImage, height: Int?, width: Int?) {
        newsPhoto.image = image
        var scale = contentView.bounds.width / CGFloat(width!)
        let constraintConstant: CGFloat?
        if scale <= 1 {
            constraintConstant = (contentView.bounds.width / CGFloat(width!)) * CGFloat(height!)
        }
        newsPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
=======
    public func configure(with image: UIImage, height: Int?, width: Int?) {
        newsPhoto.image = image
        var scale = contentView.bounds.width / CGFloat(width!)
        let constraintConstant: CGFloat?
        if scale <= 1 {
            constraintConstant = (contentView.bounds.width / CGFloat(width!)) * CGFloat(height!)
        }
        newsPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
>>>>>>> parent of 457fe3b (stable photos in news)
=======
    public func configure(with image: UIImage, height: Int?, width: Int?) {
        newsPhoto.image = image
        var scale = contentView.bounds.width / CGFloat(width!)
        let constraintConstant: CGFloat?
        if scale <= 1 {
            constraintConstant = (contentView.bounds.width / CGFloat(width!)) * CGFloat(height!)
        }
        newsPhoto.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
>>>>>>> parent of 457fe3b (stable photos in news)
            newsPhoto.heightAnchor.constraint(equalToConstant: (contentView.bounds.width / CGFloat(width!)) * CGFloat(height!)),
            newsPhoto.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            newsPhoto.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            newsPhoto.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            newsPhoto.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        
        
<<<<<<< HEAD
<<<<<<< HEAD
=======
=======
>>>>>>> parent of 457fe3b (stable photos in news)
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "PhotosInNewsCell", bundle: nil)
<<<<<<< HEAD
>>>>>>> parent of 457fe3b (stable photos in news)
=======
>>>>>>> parent of 457fe3b (stable photos in news)
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "PhotosInNewsCell", bundle: nil)
>>>>>>> parent of 457fe3b (stable photos in news)
    }
    
    override func layoutSubviews() {
        setConstraints()
    }
}
