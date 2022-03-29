//
//  ShowMainPhotoViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 09.03.2022.
//

import UIKit

class ShowMainPhotoViewController: UIViewController {

    @IBOutlet weak var showMainPhoto: UIImageView!
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var likeControl: LikeControl!
    @IBOutlet weak var likePicture: UIImageView!
    
    var image: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 1
        container.addGestureRecognizer(tap)
        
        showMainPhoto.image = image
    }
    
    @objc func handleTap(_ : UIGestureRecognizer){
        
        print("tap")
        likeControl.islike.toggle()
        
        if likeControl.islike {
            
            likeControl.plusOneLike()
        } else {
            likeControl.minusOneLike()
        }
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
