//
//  TextInNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class TextInNewsCell: UITableViewCell {

    private var indexPath: IndexPath!
    private var tableView: UITableView!
    private var nvc: NewsViewController!
    
    private var isSeeLess = true
    
    static let identifier: String = "TextInNewsCell"
    var height: CGFloat?
    private var numberOfLines: Int = 2

    let newsTextLabel: UILabel = {
        let newsTextLabel = UILabel()
        
        let labelFont = UIFont.systemFont(ofSize: 15)
        newsTextLabel.font = labelFont
        newsTextLabel.lineBreakMode = .byWordWrapping
        newsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return newsTextLabel
    }()

    let showMoreButton: IndexedButton = {
        let showMoreButton = IndexedButton(frame: CGRect(x: 100, y: 100, width: 100, height: 18))
        showMoreButton.configuration = UIButton.Configuration.plain()
        showMoreButton.contentMode = .scaleAspectFill
        showMoreButton.contentHorizontalAlignment = .left
        showMoreButton.configuration?.title = "Показать полностью.."
        showMoreButton.addTarget(self, action: #selector(showMoreAction), for: .touchUpInside)
        showMoreButton.translatesAutoresizingMaskIntoConstraints = false
        return showMoreButton
    }()
    
    lazy var textStackView: UIStackView = {
        let textStackView = UIStackView(arrangedSubviews: [newsTextLabel, showMoreButton])
        textStackView.axis = .vertical
        textStackView.spacing = 5
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        return textStackView
    }()
    
    @objc func showMoreAction(_ sender: IndexedButton) {
        self.isSeeLess.toggle()
        
        self.showMoreButton.configuration?.title = isSeeLess ? "Показать полностью.." : "Свернуть текст"
        self.numberOfLines = isSeeLess ? 2 : 0
        
        self.nvc.newsResponse.items[sender.indexPath.section].isTextShowMore.toggle()
        self.contentView.layoutSubviews()
        nvc.newsResponse.items[indexPath.section].isTextShowMore.toggle()
        
        UIView.animate(withDuration: 0,
                       delay: 0) {
            self.nvc.tableView.reloadSections(IndexSet.init(integer: sender.indexPath.section), with: .automatic)
        }
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


    func configure(_ text: String?, labelHeight: CGFloat?, vc: NewsViewController, indexPath: IndexPath) {
        newsTextLabel.text = text
        
        self.indexPath = indexPath
        self.height = labelHeight
        self.nvc = vc

        if self.newsTextLabel.numberOfVisibleLines < newsTextLabel.maxNumberOfLines,
            newsTextLabel.maxNumberOfLines > 2 {
            self.showMoreButton.isHidden = false
        } else {
            self.showMoreButton.isHidden = true
        }
    }

    private func setConstraints() {
        
        contentView.addSubview(newsTextLabel)
        contentView.addSubview(showMoreButton)
        
        let topConstraint = newsTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0)
            
            NSLayoutConstraint.activate([
                showMoreButton.topAnchor.constraint(equalTo: newsTextLabel.bottomAnchor, constant: 0),
                showMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
                showMoreButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3),
                showMoreButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
                
                topConstraint,
                newsTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                newsTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            ])
        topConstraint.priority = .init(999)
      
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        newsTextLabel.numberOfLines = numberOfLines
    }
}

extension UILabel {
    var maxNumberOfLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let text = (self.text ?? "") as NSString
        let textHeight = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font as UIFont], context: nil).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight / lineHeight))
    }
}

extension UILabel {
    var numberOfVisibleLines: Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        let textHeight = sizeThatFits(maxSize).height
        let lineHeight = font.lineHeight
        return Int(ceil(textHeight) / ceil(lineHeight))
    }
}

class IndexedButton: UIButton {
    var indexPath = IndexPath(row: 0, section: 0)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}
