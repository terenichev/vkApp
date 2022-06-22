//
//  TextInNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class TextInNewsCell: UITableViewCell {

    private var imageService: ImageService?
    private var indexPath: IndexPath!
    private var tableView: UITableView!
    var nvc: NewsViewController!
    
    static let identifier: String = "TextInNewsCell"
    var height: CGFloat?
    private var numberOfLines: Int = 2

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
        let showMoreButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        showMoreButton.configuration = UIButton.Configuration.plain()
        showMoreButton.configuration?.title = "Показать полностью.."
        showMoreButton.titleLabel?.textAlignment = .left
        let labelFont = UIFont.systemFont(ofSize: 15)
        
        
        showMoreButton.addTarget(self, action: #selector(showMoreAction), for: .touchUpInside)
        showMoreButton.translatesAutoresizingMaskIntoConstraints = false
        return showMoreButton
    }()
    
    @objc func showMoreAction() {
        self.numberOfLines = 0
//        self.tableView.reloadRows(at: [indexPath], with: .automatic)
//        showMoreButton.isHidden = true
//        imageService?.reloadCell(atIndexPath: indexPath)

        nvc.tableView.reloadRows(at: [indexPath], with: .automatic)
        
        print("SHOW MORE, indexPath = ", indexPath)
        print("SHOW MORE, numberOfLines = ", numberOfLines)
        print("SHOW MORE, labelHeight = ", height)

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

    func configure(_ text: String?, labelHeight: CGFloat?, tableView: UITableView, indexPath: IndexPath, vc: NewsViewController) {
        newsTextLabel.text = text
        self.imageService = ImageService(container: tableView)
        self.tableView = tableView
        self.indexPath = indexPath
        self.height = labelHeight
        self.nvc = vc
        
        
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
                showMoreButton.topAnchor.constraint(equalTo: newsTextLabel.bottomAnchor, constant: -10),
                showMoreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
                showMoreButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                showMoreButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -200),
                
                topConstraint,
//                newsTextLabel.bottomAnchor.constraint(equalTo: showMoreButton.topAnchor, constant: 0),
                newsTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
                newsTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            ])
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
        return Int(ceil(textHeight) / ceil(lineHeight))
    }
}
