//
//  avatarUIView.swift
//  vkApp
//
//  Created by Денис Тереничев on 26.02.2022.
//

import UIKit

class avatarUIView: UIView {

    @IBOutlet var avatarImage: UIImageView!
    @IBOutlet var shadowView: UIView!
    
    var shadowColor = UIColor.black
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 2)
        shadowView.layer.shadowRadius = 2
        shadowView.layer.shadowOpacity = 0.7
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnAvatar))
        tap.numberOfTapsRequired = 1
        shadowView.addGestureRecognizer(tap)
        
    }
    
    @objc func tapOnAvatar(){
        print("tap on avatar")
        
        UIView.animate(withDuration: 0.5, delay: 0,
        usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],
        animations: {
            
            self.avatarImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.shadowView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
        })
    
        UIView.animate(withDuration: 0.5, delay: 0.2,
        usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [],
        animations: {
            
            self.avatarImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.shadowView.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        })
    
    }
    
    override func layoutSubviews() {
        avatarImage.layer.cornerRadius = bounds.height/2
        shadowView.layer.cornerRadius = bounds.height/2
        self.layer.cornerRadius = bounds.height/2
    }
}
