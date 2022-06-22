//
//  DynamicLabelHeight.swift
//  vkApp
//
//  Created by Денис Тереничев on 21.06.2022.
//

import UIKit

class DynamicLabelHeight {
    static func height(text: String?, font: UIFont, width: CGFloat) -> CGFloat {
        var currentHeight: CGFloat!
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.text = text
        label.font = font
        label.numberOfLines = 0
//        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        
        currentHeight = label.frame.height
        label.removeFromSuperview()        
        
        return currentHeight
    }
    
    
}
