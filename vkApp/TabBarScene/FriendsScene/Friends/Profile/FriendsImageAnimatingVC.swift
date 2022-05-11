//
//  FriendsImageAnimatingVC.swift
//  vkApp
//
//  Created by Денис Тереничев on 02.04.2022.
//

import UIKit

class FriendsImageAnimatingVC: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    
    @IBOutlet weak var secondImageView: UIImageView!
    
    var arrayImages:[UIImage?]?
    var selectedIndex:Int = 1
    
    var firstImagePosition: CGAffineTransform!
    var secondImagePosition: CGAffineTransform!
    
    var showedPhotoIndex:Int = 0
    var indexCount:Int = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.title = "\(showedPhotoIndex + 1) из \(self.arrayImages!.count)"
        
        let imageRightPosition = CGAffineTransform(translationX: view.frame.maxX + 20, y: 0)
        let imageCenterPosition = CGAffineTransform(translationX: 0, y: 0)
        
        firstImagePosition = imageCenterPosition
        secondImagePosition = imageRightPosition
        
        firstImageView.image = arrayImages?[showedPhotoIndex]
        secondImageView.transform = imageRightPosition
        if showedPhotoIndex != indexCount{
            secondImageView.image = arrayImages?[showedPhotoIndex+1]
        }else {
            secondImageView.image = nil
        }
        
        let panGR = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        view.addGestureRecognizer(panGR)
    }
    
    @objc func viewPanned(_ recogniser: UIPanGestureRecognizer) {
        var secondNewPos: CGAffineTransform!
        
        switch recogniser.state {
            
        case .changed:
            let percentY = (recogniser.translation(in: view).y/view.frame.maxY) * 100
            
            let percent = (recogniser.translation(in: view).x/view.frame.maxX) * 100
            let percentAbs = abs(percent)
            let scaleMultiplication = max((100 - percentAbs)/100, 1/3)
            
            let alphaMultiplication = max((100 - 1.5 * percentAbs)/100, 0)
            
            if percentY > 30 {
                self.navigationController?.popViewController(animated: true)
            }
            
            if percent < 0 {
                firstImageView.image = arrayImages?[showedPhotoIndex]
                
                if self.showedPhotoIndex != self.indexCount {
                    self.secondImageView.image = arrayImages?[self.showedPhotoIndex+1]
                    
                    firstImageView.transform = CGAffineTransform(scaleX: scaleMultiplication, y: scaleMultiplication)
                    firstImageView.alpha = alphaMultiplication
                    
                    secondImageView.transform = CGAffineTransform(translationX: recogniser.translation(in: view).x + view.frame.maxX + 10, y: 0)
                }else {
                    
                    self.secondImageView.image = nil
                    firstImageView.alpha = 1
                    firstImageView.transform = CGAffineTransform(translationX: recogniser.translation(in: view).x, y: 0)
                }
                
            }else {
                if showedPhotoIndex != 0 {
                    firstImageView.image = arrayImages?[showedPhotoIndex-1]
                    secondImageView.image = arrayImages?[showedPhotoIndex]
                    firstImageView.transform = CGAffineTransform(scaleX: min(abs(1-(1/scaleMultiplication)), 1), y: min(abs(1-(1/scaleMultiplication)), 1))
                    firstImageView.alpha = abs(1-alphaMultiplication)
                    secondImageView.transform = CGAffineTransform(translationX: recogniser.translation(in: view).x, y: 0)
                }else if showedPhotoIndex == 0{
                    firstImageView.image = nil
                    secondImageView.image = arrayImages?[showedPhotoIndex]
                    secondImageView.transform = CGAffineTransform(translationX: recogniser.translation(in: view).x, y: 0)
                }
            }
            
        case .ended:
            
            let percent = (recogniser.translation(in: view).x/view.frame.maxX) * 100
            //листаем вперед
            if percent < -50 {
                
                if self.showedPhotoIndex < indexCount {
                    
                    UIView.animate(withDuration: 0.1) {
                        
                        secondNewPos = CGAffineTransform(translationX: 0, y: 0)
                        
                        self.secondImageView.transform = secondNewPos
                        
                    } completion: { _ in
                        self.showedPhotoIndex += 1
                        
                        self.firstImageView.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.secondImageView.transform = CGAffineTransform(translationX: self.view.frame.maxX + 20, y: 0)
                        
                        self.title = "\(self.showedPhotoIndex + 1) из \(self.arrayImages?.count)"
                        self.firstImageView.image = self.arrayImages?[self.showedPhotoIndex]
                        self.firstImageView.alpha = 1
                        
                        if self.showedPhotoIndex != self.indexCount {
                            self.secondImageView.image = self.arrayImages?[self.showedPhotoIndex+1]
                        }else {
                            self.secondImageView.image = nil
                        }
                    }
                }
                
                if self.showedPhotoIndex == indexCount {
                    self.secondImageView.image = nil
                    UIView.animate(withDuration: 0.1) {
                        self.firstImageView.transform = .identity
                        self.secondImageView.transform = .identity
                    } completion: { _ in
                        self.firstImageView.image = self.arrayImages?[self.showedPhotoIndex]
                        self.firstImageView.alpha = 1
                        self.secondImageView.image = nil
                    }
                }
            //листаем назад
            }else if percent > 50 {
                if self.showedPhotoIndex > 0 {
                    UIView.animate(withDuration: 0.1) {
                        secondNewPos = CGAffineTransform(translationX: self.view.frame.maxX + 20, y: 0)
                        self.secondImageView.transform = secondNewPos
                    }completion: { _ in
                        self.showedPhotoIndex -= 1
                        
                        self.firstImageView.transform = CGAffineTransform(translationX: 0, y: 0)
                        self.secondImageView.transform = CGAffineTransform(translationX:0, y: 0)
                        
                        self.title = "\(self.showedPhotoIndex + 1) из \(self.arrayImages?.count)"
                        
                        self.secondImageView.image = self.arrayImages?[self.showedPhotoIndex]
//                        self.firstImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
                        self.firstImageView.alpha = 0
                        
                        if self.showedPhotoIndex != 0 {
                            self.firstImageView.image = self.arrayImages?[self.showedPhotoIndex-1]
                        }else {
                            self.firstImageView.image = nil
                            self.secondImageView.image = self.arrayImages?[self.showedPhotoIndex]
                        }
                    }
                }
                
                if self.showedPhotoIndex == 0 {
                    UIView.animate(withDuration: 0.1) {
                        self.firstImageView.transform = .identity
                        self.secondImageView.transform = .identity
                    } completion: { _ in
                        self.firstImageView.image = nil
                        self.firstImageView.alpha = 1
                        self.secondImageView.image = self.arrayImages?[self.showedPhotoIndex]
                    }
                }
            //В случае маленького свайпа отменяем перелистывание
            }else if percent < 0 && percent >= -50 {
                UIView.animate(withDuration: 0.1) {
                    self.firstImageView.transform = .identity
                    self.firstImageView.alpha = 1
                    self.secondImageView.transform = CGAffineTransform(translationX: self.view.frame.maxX + 20, y: 0)
                }
            }else if percent > 0 && percent < 50 {
                UIView.animate(withDuration: 0.1) {
                    if self.showedPhotoIndex != 0 && self.showedPhotoIndex != self.indexCount{
                        self.firstImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
                        self.firstImageView.alpha = 0
                    }else {
                        self.firstImageView.image = nil
                    }
                    self.secondImageView.transform = CGAffineTransform(translationX: 0, y: 0)
                }
            }
        default:
            break
        }
    }
}

extension FriendsImageAnimatingVC: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatorModal()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatorModal()
    }
}
