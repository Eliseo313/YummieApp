//
//  ListDishesViewController.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 15/07/24.
//

import UIKit

class ListDishesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var category: DishCategory!
    
    var dishes: [Dish] = [
        .init(id: "id1", name: "Morisqueta", description: "La más pedida!", image: "https://picsum.photos/100/200", calories: 700),
        .init(id: "id2", name: "Pechuga asada", description: "Delicioso!", image: "https://picsum.photos/100/200", calories: 300),
        .init(id: "id3", name: "Mole", description: "Especialidad de la casa", image: "https://picsum.photos/100/200", calories: 500)
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = category.name
        registerCells()
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
    
    
}
