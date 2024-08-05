//
//  Dish.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 10/07/24.
//

import Foundation

struct Dish: Decodable{
    let vNombre,vDescripcion,vImagen,vCalorias: String?
    let idPlatillo,idCategoria: Int?
    let bIsPopular,bIsEspecial: Int?
    
    var formattedCalories: String {
        return "\(vCalorias ?? " ") calorias"
    }
}
