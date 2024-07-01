//
//  OnboardingCollectionViewCell.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 30/06/24.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self
    );
    
    @IBOutlet weak var slideTittleLbl: UILabel!
    @IBOutlet weak var slideImageView: UIImageView! 
    @IBOutlet weak var slideDescriptionLbl: UILabel!
    
    //Constructor de la clase
    func setup(_ slide: OnboardingSlide){
        slideImageView.image = slide.image
        slideTittleLbl.text = slide.tittle
        slideDescriptionLbl.text = slide.description
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier , for: <#T##IndexPath#>) as!OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    
}
