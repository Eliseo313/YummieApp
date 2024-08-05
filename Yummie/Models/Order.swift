//
//  Order.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 15/07/24.
//

import Foundation

struct Order: Decodable {
    let idOrden : Int?
    let vNombre : String?
    let platillo: Dish?
}
