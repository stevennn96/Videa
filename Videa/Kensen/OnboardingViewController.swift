//
//  OnboardingViewController.swift
//  Videa
//
//  Created by Nurfarah Alyavianti on 27/08/18.
//  Copyright © 2018 Steven. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var onboardingImageView: UIImageView!
    
    @IBOutlet weak var doneButton: UIButton!
    var index = 0
    var imageList:[String] = ["onboarding 1","onboarding 2","onboarding 3","onboarding 4"]
    
    @objc func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            
            switch swipeGesture.direction{
                
                case UISwipeGestureRecognizerDirection.right:
                    index -= 1
                    if index < 0{
                        index = 0
                    }
                    
                    if index < imageList.count-1{
                        doneButton.isHidden = true
                    }
        
                    
                    UIView.transition(with: onboardingImageView, duration: 0.2, options: .transitionCrossDissolve, animations: {
                        self.onboardingImageView.image = UIImage(named: self.imageList[self.index])
                    }, completion: nil)
             
                case UISwipeGestureRecognizerDirection.left:
                    index += 1
                    if index > imageList.count-1 {
                        index = imageList.count-1
                    }
                    if index == imageList.count-1{
                        doneButton.isHidden = false
                    }
                    UIView.transition(with: onboardingImageView, duration: 0.2, options: .transitionCrossDissolve, animations: {
                        self.onboardingImageView.image = UIImage(named: self.imageList[self.index])
                    }, completion: nil)
                
            default:
                break
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    doneButton.layer.cornerRadius = 5
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
