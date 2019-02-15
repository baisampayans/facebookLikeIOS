//
//  ViewController.swift
//  facebookLikeAnimation
//
//  Created by Baisampayan Saha on 2/14/19.
//  Copyright © 2019 Baisampayan Saha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let size = 36
    let padding = 12
    let numberOfButtons = 6

    let iconsContainer : UIView = {
        
        let size: CGFloat = 44
        let numberOfButtons = 6
        
        let containerView = UIView()
        
        
        let images = [#imageLiteral(resourceName: "like"), #imageLiteral(resourceName: "smile"), #imageLiteral(resourceName: "laugh"), #imageLiteral(resourceName: "thinking"), #imageLiteral(resourceName: "cry"), #imageLiteral(resourceName: "angry")]
        let arrangedView = images.map({(image) -> UIView in
            let v = UIImageView(image: image)
            v.layer.cornerRadius = size/2
            v.isUserInteractionEnabled = true
            
            return v
        })
        

        let stackView = UIStackView(arrangedSubviews: arrangedView)
        stackView.distribution = .fillEqually
        
        let padding: CGFloat = 8
        stackView.spacing = padding
        stackView.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        containerView.addSubview(stackView)
        
        let containerViewWidth = (CGFloat(numberOfButtons) * size) + (padding * (CGFloat(numberOfButtons) + 1))
        let containerViewHeight = padding * 2 + size
        
        containerView.frame = CGRect(x: 0, y: 0, width: containerViewWidth, height: containerViewHeight)
        containerView.backgroundColor = .white
        containerView.layer.shadowRadius = 4
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowOpacity = 0.4
        containerView.layer.cornerRadius = containerView.frame.height/2
        
        
        stackView.frame = containerView.frame
        
        return containerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iconsContainer.alpha = 0
        
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
        
    }
    @objc fileprivate func handleLongPress(gesture: UILongPressGestureRecognizer){
        if gesture.state == .began {
            handleGestureBegan(gesture: gesture)
        } else if gesture.state == .ended {
            handleGestureEnded(gesture: gesture)
        } else if gesture.state == .changed {
            handleLongPressIcons(gesture: gesture)
        }
    }
    
    fileprivate func handleGestureBegan(gesture: UILongPressGestureRecognizer){
        let location = gesture.location(in: self.view)
        
        let locationX = (view.frame.width - iconsContainer.frame.width)/2
        let locationY = location.y - iconsContainer.frame.height + 50
        
        view.addSubview(iconsContainer)
       self.iconsContainer.transform = CGAffineTransform(translationX: locationX, y: locationY)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.iconsContainer.alpha = 1
            self.iconsContainer.transform = CGAffineTransform(translationX: locationX, y: locationY - 70)
        }, completion: nil)
        
        
    }
    
    fileprivate func handleGestureEnded(gesture: UILongPressGestureRecognizer) {
        iconsContainer.removeFromSuperview()
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            let stackView = self.iconsContainer.subviews.first
            stackView?.subviews.forEach({ (imageView) in
                imageView.transform = .identity
            })
            self.iconsContainer.alpha = 1
            self.iconsContainer.transform = CGAffineTransform(translationX: 0, y: 50)
        }) { (action) in
            
        }
    }
    
    
    fileprivate func handleLongPressIcons(gesture: UILongPressGestureRecognizer){
        let pressedLocation = gesture.location(in: iconsContainer)
        
        
        guard let hitTests = iconsContainer.hitTest(pressedLocation, with: nil) else {return}
        
        if hitTests is UIImageView {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                
                let stackView = self.iconsContainer.subviews.first
                stackView?.subviews.forEach({ (imageView) in
                    imageView.transform = .identity
                })
                
                hitTests.transform = CGAffineTransform(translationX: 0, y: -55)
            }, completion: nil)
        } else {
            
        }
    }
    
    
    
}

