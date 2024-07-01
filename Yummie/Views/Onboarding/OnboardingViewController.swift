//
//  OnboardingViewController.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 29/06/24.
//

import UIKit

class OnboardingViewController: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var netxBtn: UIButton!
    
    var slides : [OnboardingSlide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func nextBtnClicked(_ sender: UIButton) {
    }
    

}
