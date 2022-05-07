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
    
    let transition = PopAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyCollectionView.register(profilePhotosViewCell.nib(), forCellWithReuseIdentifier: profilePhotosViewCell.identifier)
        self.MyCollectionView.dataSource = self
        self.MyCollectionView.delegate = self
        
        mainPhotoOfProfile.layer.cornerRadius = 50
    
        mainPhotoOfProfile.image = profileForFriend.mainImage
        nameInProfileLabel.text = profileForFriend.name
        friendStatusInProfile.text = profileForFriend.statusText
    
    }
    
}

extension profileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let friendsImageAnimatingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FriendsImageAnimatingVC") as! FriendsImageAnimatingVC
        
        friendsImageAnimatingVC.transitioningDelegate = friendsImageAnimatingVC
        
        let indexPath = self.MyCollectionView!.indexPathsForSelectedItems!
        let index = indexPath[0] as NSIndexPath
        
        friendsImageAnimatingVC.friend = profileForFriend
        friendsImageAnimatingVC.showedPhotoIndex = index.row
        friendsImageAnimatingVC.indexCount = profileForFriend.images.count - 1
        
        self.navigationController?.pushViewController(friendsImageAnimatingVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: profilePhotosViewCell.identifier, for: indexPath) as! profilePhotosViewCell
        self.arrayImages.removeFirst()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showBigPhoto",
           let destinationVC = segue.destination as? ShowMainPhotoViewController
            {
            destinationVC.image = profileForFriend.mainImage
        }
        
        if segue.identifier == "showBigPhotoCell",
           let destinationVC = segue.destination as? BigPhotoFromViewCellViewController
            {
            let indexPath = self.MyCollectionView!.indexPathsForSelectedItems!
            let index = indexPath[0] as NSIndexPath
            destinationVC.imageFromProfilCell = profileForFriend.images[index.row]
            destinationVC.friend = profileForFriend
            destinationVC.selectedIndex = index.row
        }
            if segue.identifier == "showAnimatingPhotos",
               let destinationVC = segue.destination as? FriendsImageAnimatingVC
                {
                let indexPath = self.MyCollectionView!.indexPathsForSelectedItems!
                let index = indexPath[0] as NSIndexPath
                destinationVC.friend = profileForFriend
                destinationVC.showedPhotoIndex = index.row
                destinationVC.indexCount = profileForFriend.images.count - 1
        }
    }
}

extension profileViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatorModal()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatorModal()
    }
}

