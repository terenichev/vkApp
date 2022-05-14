//
//  profileViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 01.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var mainPhotoOfProfile: UIImageView!
    @IBOutlet weak var nameInProfileLabel: UILabel!
    @IBOutlet weak var friendStatusInProfile: UILabel!
    
    @IBOutlet weak var container: UIView!
    
    let service = FriendsRequests()
    
    var profileForFriend: FriendsItem!
    
    var arrayImageUrl: [URL] = []
    var arrayImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.register(ProfilePhotosViewCell.nib(), forCellWithReuseIdentifier: ProfilePhotosViewCell.identifier)
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
        
        nameInProfileLabel.text = profileForFriend.firstName + " " + profileForFriend.lastName
        friendStatusInProfile.text = profileForFriend.status ?? ""
        loadAvatar()
        loadFriendData()
    }
}

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImageUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if arrayImages.count == arrayImageUrl.count {
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: ProfilePhotosViewCell.identifier, for: indexPath) as! ProfilePhotosViewCell
            let image = arrayImages[indexPath.row]
            cell.configure(with: image)
            return cell
        } else {
            let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: ProfilePhotosViewCell.identifier, for: indexPath) as! ProfilePhotosViewCell
            let image = UIImage(named: "not photo")!
            DispatchQueue.global(qos: .utility).async {
                let imageFromUrl = self.service.imageLoader(url: self.arrayImageUrl[indexPath.row])
                self.arrayImages.append(imageFromUrl)
                DispatchQueue.main.async {
                    cell.configure(with: imageFromUrl)
                }
            }
            cell.configure(with: image)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let friendsImageAnimatingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FriendsImageAnimatingVC") as! FriendsImageAnimatingVC

        let indexPath = self.myCollectionView!.indexPathsForSelectedItems!
        let index = indexPath[0] as NSIndexPath

//        friendsImageAnimatingVC.arrayImages = arrayImages
//        friendsImageAnimatingVC.showedPhotoIndex = index.row
//        friendsImageAnimatingVC.indexCount = arrayImages.count - 1
        
        self.navigationController?.pushViewController(friendsImageAnimatingVC, animated: true)
    }

    @objc func showMainPhoto() {
        performSegue(withIdentifier: "showBigPhoto", sender: self)
        UIView.animate(withDuration: 0.5) {
        }
    }
}

extension ProfileViewController {
    func loadAvatar() {
        mainPhotoOfProfile.layer.cornerRadius = 50
        
        mainPhotoOfProfile.image = UIImage(named: "not photo")
        let url = URL(string: profileForFriend.avatarUrl)
        DispatchQueue.global(qos: .utility).async {
            let imageFromUrl = self.service.imageLoader(url: url)
            DispatchQueue.main.async {
                self.mainPhotoOfProfile.image = imageFromUrl
            }
        }
    }
    
    func loadFriendData() {
        service.usersPhotoRequest(id: profileForFriend.id ) { [weak self] result in
            switch result {
            case .success(let array):
                var arrayImagesString: [String] = []
                array.forEach({ arrayImagesString.append($0.sizes.last!.url) })
                for string in arrayImagesString {
                    let url = URL(string: string)
                    self?.arrayImageUrl.append(url!)
                    DispatchQueue.main.async {
                        self?.myCollectionView.reloadData()
                    }
                }
            case .failure(let error):
                print("error", error)
            }
        }
    }
}
