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
        
        view.contentMode = .scaleAspectFill
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
        // буду конфигурировать ячейку в зависимости от типа вложений
        newsPhoto.image = image
    }
}


// MARK: - Private
private extension PhotosInNewsCell {
    func setupSubviews() {
        
        contentView.addSubview(backgroundCell)
        backgroundCell.addSubview(newsPhoto)
                
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            backgroundCell.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            backgroundCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            backgroundCell.heightAnchor.constraint(equalToConstant: contentView.bounds.width),
            
            newsPhoto.topAnchor.constraint(equalTo: backgroundCell.topAnchor),
            newsPhoto.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor),
            newsPhoto.leftAnchor.constraint(equalTo: backgroundCell.leftAnchor, constant: 0),
            newsPhoto.rightAnchor.constraint(equalTo: backgroundCell.rightAnchor, constant: 0),
        ])
    }
}
