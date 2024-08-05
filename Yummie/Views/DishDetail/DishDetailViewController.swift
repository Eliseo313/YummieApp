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
    
    let urlImagenes = "http://192.168.100.65:8888/Yummie/imagenes/platillos/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        populateView()
    }

    private func populateView(){
        let urlImagen = urlImagenes+(dish.vImagen ?? "")
        dishImageView.kf.setImage(with: urlImagen.asUrl)
        titleLbl.text = dish.vNombre
        descriptionLbl.text = dish.vDescripcion
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
        print("Hola,\(name)")
        let hud = JGProgressHUD(style: .dark)
        //hud.textLabel.text = "prueba..."
        hud.show(in: self.view)
        
        NetworkService.shared.placeOrder(dishId: dish.idPlatillo ?? 0 , name: name) { (result) in
            switch result{
            case .success(_):
                hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                hud.textLabel.text = "Orden creada 👨🏽‍🍳"
                hud.dismiss(afterDelay: 1.2, animated: true)
                self.navigationController?.popViewController(animated: true)

            case .failure(let error):
                let hud2 = JGProgressHUD(style: .dark)
                hud2.indicatorView = JGProgressHUDErrorIndicatorView() // Usa un ícono de error
                hud2.textLabel.text = "Error al ordenar: \(error.localizedDescription)"
                hud2.show(in: self.view)
                hud2.dismiss(afterDelay: 2.0)
                hud.dismiss()
            }
        }
    }
    
}
