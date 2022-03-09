//
//  ShowMainPhotoViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 09.03.2022.
//

import UIKit

class ShowMainPhotoViewController: UIViewController {

    @IBOutlet weak var showMainPhoto: UIImageView!
    
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        showMainPhoto.image = image
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
