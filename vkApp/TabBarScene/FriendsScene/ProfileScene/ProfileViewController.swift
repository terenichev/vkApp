//
//  profileViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 01.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var MyCollectionView: UICollectionView!
    @IBOutlet weak var mainPhotoOfProfile: UIImageView!
    @IBOutlet weak var nameInProfileLabel: UILabel!
    @IBOutlet weak var friendStatusInProfile: UILabel!
    
    @IBOutlet weak var container: UIView!
    
    var profileForFriend: FriendsItem?
    
    var arrayImages: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyCollectionView.register(ProfilePhotosViewCell.nib(), forCellWithReuseIdentifier: ProfilePhotosViewCell.identifier)
        self.MyCollectionView.dataSource = self
        self.MyCollectionView.delegate = self
        
        mainPhotoOfProfile.layer.cornerRadius = 50
    
        let url = URL(string: profileForFriend!.avatarUrl)
            if let data = try? Data(contentsOf: url!)
            {
                mainPhotoOfProfile.image = UIImage(data: data)
            }
        nameInProfileLabel.text = profileForFriend!.firstName + " " + profileForFriend!.lastName
        friendStatusInProfile.text = profileForFriend?.status ?? ""
    }
    
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let friendsImageAnimatingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FriendsImageAnimatingVC") as! FriendsImageAnimatingVC

        let indexPath = self.MyCollectionView!.indexPathsForSelectedItems!
        let index = indexPath[0] as NSIndexPath

        friendsImageAnimatingVC.arrayImages = arrayImages
        friendsImageAnimatingVC.showedPhotoIndex = index.row
        friendsImageAnimatingVC.indexCount = arrayImages.count - 1
        
        self.navigationController?.pushViewController(friendsImageAnimatingVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: ProfilePhotosViewCell.identifier, for: indexPath) as! ProfilePhotosViewCell

        cell.configure(with: arrayImages[indexPath.row]!)
        cell.imageView.layer.cornerRadius = 5
        
        return cell
        }

    @objc func showMainPhoto() {
        performSegue(withIdentifier: "showBigPhoto", sender: self)
        UIView.animate(withDuration: 0.5) {
        }
    }
}


