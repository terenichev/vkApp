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
    
    
    var profileForFriend: Friend = tonyStark
    var arrayImages: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyCollectionView.register(vandaViewCell.nib(), forCellWithReuseIdentifier: vandaViewCell.identifier)
        self.MyCollectionView.dataSource = self
        self.MyCollectionView.delegate = self
        
        mainPhotoOfProfile.layer.cornerRadius = mainPhotoOfProfile.bounds.height/2
        
        
        mainPhotoOfProfile.image = profileForFriend.mainImage
        nameInProfileLabel.text = profileForFriend.name
        friendStatusInProfile.text = profileForFriend.statusText
    }
    
    
}

extension profileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: vandaViewCell.identifier, for: indexPath) as! vandaViewCell
        
//        cell.configure(with: UIImage(named: "Ванда")!)
        
        cell.configure(with: arrayImages[indexPath.row]!)
        cell.imageView.layer.cornerRadius = 5
        return cell
        }
      
}
    
    
