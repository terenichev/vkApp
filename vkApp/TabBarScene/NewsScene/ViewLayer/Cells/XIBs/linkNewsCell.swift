//
//  linkNewsCell.swift
//  vkApp
//
//  Created by Денис Тереничев on 06.06.2022.
//

import UIKit

class linkNewsCell: UITableViewCell {

    @IBOutlet weak var linkName: UILabel!
    @IBOutlet weak var linkDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(with linkName: String?, linkDescription: String?) {
        self.linkName.text = linkName
        self.linkDescription.text = linkDescription
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
