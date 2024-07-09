//
//  CategoryCollectionViewCell.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 07/07/24.
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: CategoryCollectionViewCell.self)
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    
    func setup(category: DishCategory){
        categoryTitleLbl.text = category.name
        categoryImageView.kf.setImage(with:  category.image.asUrl)
    }
}
