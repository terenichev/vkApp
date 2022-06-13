//
//  PhotosInNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//


import UIKit

/// Ячейка, отображающая фото.
final class PhotosInNewsCell: UITableViewCell {
    
    /// Фон ячейки.
    private lazy var backgroundCell: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    /// Фото.
    var newsPhoto: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
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
        
        contentView.addSubview(backgroundCell)
        backgroundCell.addSubview(newsPhoto)
                
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundCell.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            backgroundCell.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundCell.heightAnchor.constraint(equalToConstant: contentView.bounds.width),
            
            newsPhoto.topAnchor.constraint(equalTo: backgroundCell.topAnchor),
            newsPhoto.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor),
            newsPhoto.leftAnchor.constraint(equalTo: backgroundCell.leftAnchor),
            newsPhoto.rightAnchor.constraint(equalTo: backgroundCell.rightAnchor),
        ])
    }
}
