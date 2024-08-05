//
//  DishListTableViewCell.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 15/07/24.
//

import UIKit

class DishListTableViewCell: UITableViewCell {

    static let identifier = "DishListTableViewCell"
    let urlImagenes = "http://192.168.100.65:8888/Yummie/imagenes/platillos/"
    
    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    
    func setup(dish: Dish){
        
        let urlImagen = urlImagenes+(dish.vImagen ?? "")
        dishImageView.kf.setImage(with: urlImagen.asUrl)
        titleLbl.text = dish.vNombre
        descriptionLbl.text = dish.vDescripcion
    }
    
    func setup(order: Order){
        
        let urlImagen = urlImagenes+(order.platillo?.vImagen ?? "")
        
        dishImageView.kf.setImage(with: urlImagen.asUrl)
        titleLbl.text =  order.platillo?.vNombre
        descriptionLbl.text = order.vNombre
    }
}
