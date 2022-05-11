//
//  showPhotoViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 06.03.2022.
//

import UIKit

class showPhotoViewController: UIViewController {
    @IBOutlet weak var largeMainPhotoImageViev: UIImageView!
    
    
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        largeMainPhotoImageViev.layer.cornerRadius = 5
        
    }
    


}
