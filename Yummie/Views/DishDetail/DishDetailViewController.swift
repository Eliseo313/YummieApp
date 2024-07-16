//
//  DishDetailViewController.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 14/07/24.
//

import UIKit

class DishDetailViewController: UIViewController {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var dish : Dish!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        populateView()
    }

    private func populateView(){
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        titleLbl.text = dish.name
        descriptionLbl.text = dish.description
        caloriesLbl.text = dish.formattedCalories
        
    }
    
    @IBAction func ordenarBtnClicked(_ sender: UIButton) {
        
        
    }
    
}
