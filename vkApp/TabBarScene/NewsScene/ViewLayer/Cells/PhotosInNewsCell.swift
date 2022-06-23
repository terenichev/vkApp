//
//  PhotosInNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//


import UIKit

/// Ячейка, отображающая фото.
final class PhotosInNewsCell: UITableViewCell {

    
    /// Фото.
    var newsPhoto: UIImageView = {
        let view = UIImageView()
        
//        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    /// Инициализатор ячейки.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Конфигуратор ячейки.
    func configureNewsAttachmentsCell(image: UIImage) {        
        newsPhoto.image = image
    }
    
}


// MARK: - Private
private extension PhotosInNewsCell {
    func setupSubviews() {
        
        contentView.addSubview(newsPhoto)
        
        let topConstraint = newsPhoto.topAnchor.constraint(equalTo: contentView.topAnchor)
                
        NSLayoutConstraint.activate([
            topConstraint,
            newsPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            newsPhoto.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            newsPhoto.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ])
        topConstraint.priority = .init(rawValue: 999)
    }
}
