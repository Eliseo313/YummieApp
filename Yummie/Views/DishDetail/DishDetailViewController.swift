//
//  DishDetailViewController.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 14/07/24.
//

import UIKit
import JGProgressHUD

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
        
        guard let name = nameField .text?.trimmingCharacters(in: .whitespaces),!name.isEmpty else{
            
            let hud = JGProgressHUD(style: .dark)
            hud.indicatorView = JGProgressHUDErrorIndicatorView() // Usa un ícono de error
            hud.textLabel.text = "Por favor ingresa tu nombre"
            hud.show(in: self.view)
            hud.dismiss(afterDelay: 2.0)
            
            return
        }
        //print("Hola,\(name)")
        let hud = JGProgressHUD(style: .dark)
        //hud.textLabel.text = "prueba..."
        hud.show(in: self.view)
        
        NetworkService.shared.placeOrder(dishId: dish.id ?? "", name: name) { (result) in
            switch result{
            case .success(_):
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.textLabel.text = "Orden creada 👨🏽‍🍳"
                hud.dismiss(afterDelay: 1.2, animated: true)
            case .failure(let error):
                let hud = JGProgressHUD(style: .dark)
                hud.indicatorView = JGProgressHUDErrorIndicatorView() // Usa un ícono de error
                hud.textLabel.text = "Error al ordenar: \(error.localizedDescription)"
                hud.show(in: self.view)
                hud.dismiss(afterDelay: 2.0)
            }
        }
    }
    
}
