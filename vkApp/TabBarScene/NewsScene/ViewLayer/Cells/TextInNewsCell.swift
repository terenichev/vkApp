//
//  TextInNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class TextInNewsCell: UITableViewCell {

    static let identifier: String = "TextInNewsCell"
    var height: CGFloat?

    private let newsTextLabel: UILabel = {
        let newsTextLabel = UILabel()
        
        let labelFont = UIFont.systemFont(ofSize: 15)
        newsTextLabel.font = labelFont
//        newsTextLabel.sizeToFit()
        newsTextLabel.lineBreakMode = .byWordWrapping
        newsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        return newsTextLabel
    }()

    private let showMoreButton: UIButton = {
        let showMoreButton = UIButton()
        showMoreButton.configuration = .gray()
        showMoreButton.configuration?.title = "dgdgdgdgg"
        showMoreButton.addTarget(TextInNewsCell.self, action: #selector(showMoreAction), for: .valueChanged)
        showMoreButton.translatesAutoresizingMaskIntoConstraints = false
        return showMoreButton
    }()
    
    @objc func showMoreAction() {
        newsTextLabel.numberOfLines = 0
        print("SHOW MORE")
        
    }
    
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

    func configure(_ text: String?, labelHeight: CGFloat?) {
        newsTextLabel.text = text
        
        self.height = labelHeight
        
        print("maxNumberOfLines = ", newsTextLabel.maxNumberOfLines)
        print("numberOfVisibleLines = ", newsTextLabel.numberOfVisibleLines)
        print("")
        if self.newsTextLabel.numberOfVisibleLines < newsTextLabel.maxNumberOfLines,
            newsTextLabel.maxNumberOfLines > 2 {
            self.showMoreButton.isHidden = false
        } else {
            self.showMoreButton.isHidden = true
        }
    }

    private func setConstraints() {
        
        contentView.addSubview(newsTextLabel)
        let topConstraint = newsTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
        topConstraint.priority = .init(999)
            contentView.addSubview(showMoreButton)
            NSLayoutConstraint.activate([
                topConstraint,
                showMoreButton.topAnchor.constraint(equalTo: newsTextLabel.bottomAnchor, constant: 0),
                showMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
                showMoreButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                showMoreButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
                
                topConstraint,
                newsTextLabel.bottomAnchor.constraint(equalTo: showMoreButton.topAnchor, constant: 0),
                newsTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                newsTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newsTextLabel.numberOfLines = 2
    }
}

extension UILabel {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}

extension UILabel {
    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(textHeight / lineHeight)
    }
}
