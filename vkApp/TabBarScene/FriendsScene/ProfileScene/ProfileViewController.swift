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
    
    @IBOutlet weak var lastSeenLabel: UILabel!
    
    let service = FriendsRequests()
    let userServise = UserRequests()
    
    var id: Int!
    var profileForFriend: User!
    
    var arrayImageUrl: [URL] = []
    var arrayImages: [UIImage] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFriendData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myCollectionView.register(ProfilePhotosViewCell.nib(), forCellWithReuseIdentifier: ProfilePhotosViewCell.identifier)
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(0), execute: {
            self.setData()
        })
        
    }
}

// MARK: - Collection View
extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImageUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: ProfilePhotosViewCell.identifier, for: indexPath) as! ProfilePhotosViewCell
        let image = UIImage(named: "not photo")!
        DispatchQueue.global(qos: .default).async {
            let imageFromUrl = self.service.imageLoader(url: self.arrayImageUrl[indexPath.row])
            DispatchQueue.main.async {
                cell.configure(with: imageFromUrl)
            }
        }
        cell.configure(with: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let showPhotoVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowPhotoViewController") as! ShowPhotoViewController
        let indexPath = self.myCollectionView!.indexPathsForSelectedItems!
        let index = indexPath[0] as NSIndexPath
        showPhotoVC.arrayImageUrl = arrayImageUrl
        showPhotoVC.selectedIndex = index.row
        self.navigationController?.pushViewController(showPhotoVC, animated: true)
    }
}

// MARK: - Private
private extension ProfileViewController {
    func setData() {

        let date = Date(timeIntervalSince1970: 1653412549)
        print("\(date)")
        lastSeenLabel.isHidden = true
//        lastSeenLabel.text = "был в сети в \(date.formatted(date: .omitted, time: .shortened))"
        
        
        nameInProfileLabel.text = profileForFriend.firstName + " " + profileForFriend.lastName
        friendStatusInProfile.text = profileForFriend.status ?? ""
        mainPhotoOfProfile.layer.cornerRadius = 50
        mainPhotoOfProfile.image = UIImage(named: "not photo")
        let url = URL(string: profileForFriend.photo200_Orig)
        DispatchQueue.global(qos: .default).async {
            let imageFromUrl = self.service.imageLoader(url: url)
            DispatchQueue.main.async {
                self.mainPhotoOfProfile.image = imageFromUrl
            }
        }
    }
    
    func loadFriendData() {
        userServise.loadUserData(id: self.id) { [weak self] result in
            switch result {
            case .failure(let error):
                print("error load user data", error)
            case .success(let user):
                DispatchQueue.main.async {
                    self?.profileForFriend = user
                }
                
                print(self?.profileForFriend)
            }
        }

        service.friendsPhotoRequest(id: self.id ) { [weak self] result in
            switch result {
            case .success(let array):
                var arrayImagesString: [String] = []
                array.forEach({ arrayImagesString.append($0.sizes.last!.url) })
                var reversedPhotosArray: [URL] = []
                for string in arrayImagesString {
                    let url = URL(string: string)
                    reversedPhotosArray.append(url!)
                    self?.arrayImageUrl = reversedPhotosArray.reversed()
                    
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
