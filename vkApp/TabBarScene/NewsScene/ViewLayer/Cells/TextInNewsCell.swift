//
//  TextInNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class TextInNewsCell: UITableViewCell {

    static let identifier: String = "TextInNewsCell"

    private let newsTextLabel: UILabel = {
        let newsTextLabel = UILabel()
        newsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return newsTextLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func configure(_ text: String?) {
        newsTextLabel.text = text
    }

    private func setConstraints() {

        contentView.addSubview(newsTextLabel)
        let topConstraint = newsTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor)

        NSLayoutConstraint.activate([
            topConstraint,
            newsTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            newsTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            newsTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        ])
        topConstraint.priority = .init(999)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        newsTextLabel.numberOfLines = 3
    }
}
