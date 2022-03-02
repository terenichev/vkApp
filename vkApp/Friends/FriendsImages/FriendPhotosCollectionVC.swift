//
//  FriendPhotosCollectionVC.swift
//  vkApp
//
//  Created by Денис Тереничев on 23.02.2022.
//

import UIKit

private let reuseIdentifier = "Cell"

class FriendPhotosCollectionVC: UICollectionViewController {

    var arrayImages: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return arrayImages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotoCell", for: indexPath) as? FriendPhotoCollectionViewCell else {
            preconditionFailure("Error")
        }
    
        cell.imagesOfFriend.image = arrayImages[indexPath.row]
    
        return cell
    }


}
