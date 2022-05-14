//
//  ShowPhotoViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 14.05.2022.
//

import UIKit

class BigPhotoFromViewCellViewController: UIViewController {
    
    @IBOutlet weak var collectionBigPhoto: UICollectionView!
    
    
    var arrayImages:[UIImage?]? = nil
    var selectedIndex:Int = 0
    
    
    var imageFromProfilCell: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionBigPhoto.register(PhotoCollectionViewCell.nib(), forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        self.collectionBigPhoto.dataSource = self
        self.collectionBigPhoto.delegate = self
        
        
        self.title = "\(selectedIndex + 1) из \(self.friend.images.count)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.collectionBigPhoto.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .bottom, animated: false)
        
    }
}


extension BigPhotoFromViewCellViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionBigPhoto.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        
        cell.configure(with: friend.images[indexPath.row]!)
        cell.bigImage.layer.cornerRadius = 5
        
        
//        self.title = "\(indexPath.row + 1) из \(friend.images.count)"
       
        return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 10, height: UIScreen.main.bounds.height/1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionBigPhoto {
            let cells = collectionBigPhoto.visibleCells
            for cell in cells {
                let selectedIndexPath = self.collectionBigPhoto.indexPath(for: cell)
                print(selectedIndexPath!)
                self.title = "\((selectedIndexPath?[1])! + 1) из \(self.friend.images.count)"
            }
        }
    }
    
    
}
