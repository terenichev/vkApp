//
//  TextInNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 15.05.2022.
//

import UIKit

class TextInNewsCell: UITableViewCell {

    @IBOutlet weak var newsText: UITextView!
    
    static let identifier = "TextInNewsCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with text: String) {
        newsText.text = text
        newsText.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static func nib() -> UINib{
        return UINib(nibName: "TextInNewsCell", bundle: nil)
        
    }
    
}
