//
//  profileViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 01.03.2022.
//

import UIKit

class profileViewController: UIViewController {

    
    @IBOutlet weak var MyCollectionView: UICollectionView!
    @IBOutlet weak var mainPhotoOfProfile: UIImageView!
    @IBOutlet weak var nameInProfileLabel: UILabel!
    @IBOutlet weak var friendStatusInProfile: UILabel!
    
    @IBOutlet weak var container: UIView!
    
    
    var profileForFriend: Friend = tonyStark
    var arrayImages: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyCollectionView.register(profilePhotosViewCell.nib(), forCellWithReuseIdentifier: profilePhotosViewCell.identifier)
        self.MyCollectionView.dataSource = self
        self.MyCollectionView.delegate = self
        
        mainPhotoOfProfile.layer.cornerRadius = 50
    
        mainPhotoOfProfile.image = profileForFriend.mainImage
        nameInProfileLabel.text = profileForFriend.name
        friendStatusInProfile.text = profileForFriend.statusText
    
//        mainPhotoOfProfile.isUserInteractionEnabled = true
        
        let tapOnPhoto = UITapGestureRecognizer(target: self, action: #selector(showMainPhoto))
        
        container.addGestureRecognizer(tapOnPhoto)
        
        
    }
    
    
}



extension profileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: profilePhotosViewCell.identifier, for: indexPath) as! profilePhotosViewCell
        
//        cell.configure(with: UIImage(named: "Ванда")!)
        
        cell.configure(with: arrayImages[indexPath.row]!)
        cell.imageView.layer.cornerRadius = 5
        performSegue(withIdentifier: "showBigPhotoCell", sender: self)
        return cell
        }
      
    
    @IBAction func photoOutActionExit(unwindSegue: UIStoryboardSegue){
        print("exit")
    }
    
    @objc func showMainPhoto() {
        print ("tap on photo")
        performSegue(withIdentifier: "showBigPhoto", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showBigPhoto",
           let destinationVC = segue.destination as? ShowMainPhotoViewController
            {
            destinationVC.friend = profileForFriend
        }
    }
}


    
