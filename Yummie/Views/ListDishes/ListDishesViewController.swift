//
//  ListDishesViewController.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 15/07/24.
//

import UIKit
import JGProgressHUD

class ListDishesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var category: DishCategory!
    
    var dishes: [Dish] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = category.vNombre
        registerCells()
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Cargando"
        hud.show(in: self.view)
        
        NetworkService.shared.fetchCategoryDishes(categoryId: category.idCategoria ?? 0) { [weak self] (result) in
            switch result {
                
            case .success(let dishes):
                hud.dismiss()
                self?.dishes = dishes
                self?.tableView.reloadData()
            case .failure(let error ):
                hud.indicatorView = JGProgressHUDErrorIndicatorView() // Usa un ícono de error
                hud.textLabel.text = "Error al ordenar: \(error.localizedDescription)"
                hud.show(in: self!.view!)
                hud.dismiss(afterDelay: 2.0)
            }
        }
        
    }
    
    private func registerCells(){
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }

}

extension ListDishesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as! DishListTableViewCell
        cell.setup(dish: dishes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiate()
        controller.dish = dishes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
