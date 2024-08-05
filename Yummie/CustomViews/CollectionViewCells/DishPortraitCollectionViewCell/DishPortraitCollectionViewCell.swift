//
//  DishPortraitCollectionViewCell.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 09/07/24.
//

import UIKit

class DishPortraitCollectionViewCell: UICollectionViewCell {

    static let identifier = "DishPortraitCollectionViewCell"
    let urlImagenes = "http://192.168.100.65:8888/Yummie/imagenes/platillos/"
    
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    func setup(dish: Dish){
        
        let urlImagen = urlImagenes+(dish.vImagen ?? "")
        
        titleLbl.text = dish.vNombre
        dishImageView.kf.setImage(with: urlImagen.asUrl)
        caloriesLbl.text = dish.formattedCalories
        descriptionLbl.text = dish.vDescripcion
    }
    
    
}
