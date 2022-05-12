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
    
    var profileForFriend: FriendsItem?
    
    var arrayImages: [UIImage?] = []
    
    let transition = PopAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyCollectionView.register(profilePhotosViewCell.nib(), forCellWithReuseIdentifier: profilePhotosViewCell.identifier)
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

extension profileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let friendsImageAnimatingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FriendsImageAnimatingVC") as! FriendsImageAnimatingVC
        
//        friendsImageAnimatingVC.transitioningDelegate = friendsImageAnimatingVC

        let indexPath = self.MyCollectionView!.indexPathsForSelectedItems!
        let index = indexPath[0] as NSIndexPath

        friendsImageAnimatingVC.arrayImages = arrayImages
        friendsImageAnimatingVC.showedPhotoIndex = index.row
        friendsImageAnimatingVC.indexCount = arrayImages.count - 1
        
        self.navigationController?.pushViewController(friendsImageAnimatingVC, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: profilePhotosViewCell.identifier, for: indexPath) as! profilePhotosViewCell

        cell.configure(with: arrayImages[indexPath.row]!)
        cell.imageView.layer.cornerRadius = 5
        
        return cell
        }
      
    
    @IBAction func photoOutActionExit(unwindSegue: UIStoryboardSegue){
    }
    
    @objc func showMainPhoto() {
        performSegue(withIdentifier: "showBigPhoto", sender: self)
        UIView.animate(withDuration: 0.5) {
        }
    }
}

//extension profileViewController: UIViewControllerTransitioningDelegate {
//    
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return AnimatorModal()
//    }
//    
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return AnimatorModal()
//    }
//}

