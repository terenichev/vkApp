//
//  BigPhotoFromViewCellViewController.swift
//  vkApp
//
//  Created by Денис Тереничев on 09.03.2022.
//

import UIKit

class BigPhotoFromViewCellViewController: UIViewController {
    
    @IBOutlet weak var collectionBigPhoto: UICollectionView!
    
    var friend:Friend = tonyStark
    var arrayImages:[UIImage?]? = nil
    var selectedIndex:Int = 1
    
    
    var imageFromProfilCell: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionBigPhoto.register(BigPhotoFromProfileCollectionViewCell.nib(), forCellWithReuseIdentifier: BigPhotoFromProfileCollectionViewCell.identifier)
        
        self.collectionBigPhoto.dataSource = self
        self.collectionBigPhoto.delegate = self
        
        self.title = "\(selectedIndex + 1) из \(self.friend.images.count)"
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        self.collectionBigPhoto.scrollToItem(at: IndexPath(item: selectedIndex, section: 0), at: .right, animated: false)
        collectionBigPhoto.selectItem(at: IndexPath(item: selectedIndex, section: 0), animated: false, scrollPosition: .init(rawValue: UInt(selectedIndex)))
        
    }
}


extension BigPhotoFromViewCellViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friend.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionBigPhoto.dequeueReusableCell(withReuseIdentifier: BigPhotoFromProfileCollectionViewCell.identifier, for: indexPath) as! BigPhotoFromProfileCollectionViewCell
        
        cell.configure(with: friend.images[indexPath.row]!)
        cell.bigImage.layer.cornerRadius = 5
        
       
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
