//
//  profileViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 01.03.2022.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var mainPhotoOfProfile: UIImageView!
    @IBOutlet weak var nameInProfileLabel: UILabel!
    @IBOutlet weak var friendStatusInProfile: UILabel!
    
    @IBOutlet weak var lastSeenLabel: UILabel!
    
    let userServise = UserRequests()
    
    var id: Int!
    var user = User(id: 0, photo200_Orig: "", hasMobile: 0, isFriend: 0, about: "", status: "", lastSeen: .init(platform: 0, time: 0), followersCount: 0, online: 0, firstName: "", lastName: "", canAccessClosed: false, isClosed: false)
    
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
    }
}

// MARK: - Collection View
extension UserViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImageUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: ProfilePhotosViewCell.identifier, for: indexPath) as! ProfilePhotosViewCell
        let image = UIImage(named: "not photo")!
        DispatchQueue.global(qos: .default).async {
            self.userServise.imageLoader(url: self.arrayImageUrl[indexPath.row]) { image in
                DispatchQueue.main.async {
                    cell.configure(with: image)
                }
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
private extension UserViewController {
    ///Загрузка данных о пользователе и его фотографии
    func loadFriendData() {
        userServise.loadUserData(id: self.id) { [weak self] result in
            switch result {
            case .failure(let error):
                print("error load user data", error)
            case .success(let user):
                self?.user = user
                self?.setData()
            }
        }
        userServise.friendsPhotoRequest(id: self.id ) { [weak self] result in
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
    ///Выводим данные о пользователе в UI
    func setData() {
        if user.online == 1 {
            lastSeenLabel.text = "online"
        } else {
            lastSeenLabel.text = ""
        }
        DispatchQueue.main.async {
            self.nameInProfileLabel.text = self.user.firstName + " " + self.user.lastName
            self.friendStatusInProfile.text = self.user.status
            self.mainPhotoOfProfile.layer.cornerRadius = 35
            self.mainPhotoOfProfile.image = UIImage(named: "not photo")
        }
        DispatchQueue.global(qos: .default).async {
            let url = URL(string: self.user.photo200_Orig)
            self.userServise.imageLoader(url: url) { image in
                DispatchQueue.main.async {
                    self.mainPhotoOfProfile.image = image
                }
            }
        }
    }
}
