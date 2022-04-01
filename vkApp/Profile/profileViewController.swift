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
    
    @IBOutlet weak var animatingImage: UIImageView!
    
    @IBOutlet weak var container: UIView!
    
    
    var profileForFriend: Friend = tonyStark
    var arrayImages: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        animatingImage.layer.cornerRadius = 10
        
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
    
    @objc func tapOnArthur() {
        print("tap on Arthur")
        UIView.animate(withDuration: 2) {
            self.animatingImage.transform3D.m12 = 1
        }
    }
    
    @IBAction func animateY(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5) {
            
            if self.animatingImage.layer.position.y > 800 {
                self.animatingImage.layer.position.y = 550
            }else {
                self.animatingImage.layer.position.y += 100
            }
        }
    }
    
    
    @IBAction func mainPhotoAnimate(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5) {

            if self.animatingImage.layer.position.x > 500 {
                self.animatingImage.layer.position.x = -100
            }else {
                self.animatingImage.layer.position.x += 100
            }
        }
    }
    
}

extension profileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showBigPhotoCell", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: profilePhotosViewCell.identifier, for: indexPath) as! profilePhotosViewCell
        
//        cell.configure(with: UIImage(named: "Ванда")!)
        
        cell.configure(with: arrayImages[indexPath.row]!)
        cell.imageView.layer.cornerRadius = 5
        
        return cell
        }
      
    
    @IBAction func photoOutActionExit(unwindSegue: UIStoryboardSegue){
    }
    
    @objc func showMainPhoto() {
        performSegue(withIdentifier: "showBigPhoto", sender: self)
        UIView.animate(withDuration: 0.5) {
           // self.mainPhotoOfProfile.layer.position.y += 500
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
//            destinationVC.title = "\(index.row) из \(profileForFriend.images.count)"
            
        }
    }
}


    
