//
//  ListOrdersViewController.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 15/07/24.
//

import UIKit
import JGProgressHUD

class ListOrdersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var orders: [Order] = []
    
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Ordenes"
        registerCells()
        
        
        hud.textLabel.text = "Cargando"
        hud.show(in: self.view)
        
    }

    override func viewDidAppear(_ animated: Bool ) {
        
        NetworkService.shared.fetchOrders { [weak self] (result) in
             
            switch result{
            case .success(let orders):
                self?.hud.dismiss()
                self?.orders = orders
                self?.tableView.reloadData()
            case .failure(let error ):
                self?.hud.indicatorView = JGProgressHUDErrorIndicatorView() // Usa un ícono de error
                self?.hud.textLabel.text = "Error: \(error.localizedDescription)"
                self?.hud.show(in: self!.view)
                self?.hud.dismiss(afterDelay: 2.0)
            }
        }
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
        controller.dish = orders[indexPath.row].platillo
        navigationController?.pushViewController(controller, animated: true)
    }
}
