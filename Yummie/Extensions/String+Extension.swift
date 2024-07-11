//
//  String+Extension.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 07/07/24.
//

import Foundation

extension String{
    var asUrl: URL? {
        return URL(string: self )
    }
}
