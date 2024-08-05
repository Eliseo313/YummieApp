//
//  DishLandscapeCollectionViewCell.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 11/07/24.
//

import UIKit

class DishLandscapeCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: DishLandscapeCollectionViewCell.self)
    let urlImagenes = "http://192.168.100.65:8888/Yummie/imagenes/platillos/"
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    
    func setup(dish: Dish){
        let urlImagen = urlImagenes+(dish.vImagen ?? "")
        
        dishImageView.kf.setImage(with: urlImagen.asUrl)
        titleLbl.text = dish.vNombre
        descriptionLbl.text = dish.vDescripcion
        caloriesLbl.text = dish.formattedCalories
    }

}
