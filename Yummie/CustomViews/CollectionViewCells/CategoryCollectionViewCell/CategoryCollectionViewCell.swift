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
    let urlImagenes = "http://192.168.100.65:8888/Yummie/imagenes/categorias/"
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLbl: UILabel!
    
    func setup(category: DishCategory){
        let urlImagen = urlImagenes+(category.vImagen ?? "")
        categoryTitleLbl.text = category.vNombre
        //categoryImageView.kf.setImage(with:  category.vImagen?.asUrl)
        categoryImageView.kf.setImage(with:  urlImagen.asUrl)
    }
}
