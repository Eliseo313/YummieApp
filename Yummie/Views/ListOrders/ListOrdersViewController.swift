//
//  ListOrdersViewController.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 15/07/24.
//

import UIKit

class ListOrdersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var orders: [Order] = [
        .init(id: "id1", name: "Eliseo Cardenas", dish: .init(id: "id1", name: "Morisqueta", description: "La más pedida!", image: "https://picsum.photos/100/200", calories: 700)),
        .init(id: "id1", name: "Lazaro Cardenas", dish: .init(id: "id1", name: "Morisqueta", description: "La más pedida!", image: "https://picsum.photos/100/200", calories: 700)),
        .init(id: "id1", name: "Pako Cardenas", dish: .init(id: "id1", name: "Morisqueta", description: "La más pedida!", image: "https://picsum.photos/100/200", calories: 700))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ordenes"
        registerCells()
        
    }

    private func registerCells(){
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
}

extension ListOrdersViewController: UITableViewDataSource, UITableViewDelegate{
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier) as! DishListTableViewCell
        cell.setup(order: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = DishDetailViewController.instantiate()
        controller.dish = orders[indexPath.row].dish 
        navigationController?.pushViewController(controller, animated: true)
    }
}
