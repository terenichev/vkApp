//
//  Animator.swift
//  vkApp
//
//  Created by Денис Тереничев on 04.04.2022.
//

import UIKit

class AnimatorModal: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animationDuration: TimeInterval = 1
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //получаем оба контроллера
        guard let source = transitionContext.viewController(forKey: .from), let destination = transitionContext.viewController(forKey: .to) else {return}
        
        //добавляем destination в контейнер
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        source.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        
        //задаем итоговое положение вьюхи каждого из контроллера(совпадает с экраном телефона)
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        //трансформируем положение экрана на который нужно перейти
//        destination.view.transform = CGAffineTransform(translationX: 0, y: -destination.view.bounds.height)
        
        destination.view.transform = CGAffineTransform(rotationAngle: -3.14/2)
        
        
        
        //запускаем анимированное возвращение экрана в итоговое положение
        UIView.animate(withDuration: animationDuration) {
            destination.view.transform = .identity
            source.view.transform = CGAffineTransform(rotationAngle: 3.14/2)
        } completion: { completed in
            transitionContext.completeTransition(completed)
        }

    }
    
    
}
