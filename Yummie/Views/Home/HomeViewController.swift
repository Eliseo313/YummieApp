//
//  HomeViewController.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 05/07/24.
//

import UIKit
import JGProgressHUD


class HomeViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    
    var categories: [DishCategory] = []
    var populars : [Dish] = []
    var specials : [Dish] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Yummie"
    
        specialsCollectionView.dataSource = self
        specialsCollectionView.delegate = self
        
        registerCells()
        
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Cargando"
        hud.show(in: self.view)
        
        NetworkService.shared.fetchAll { [weak self] result in
            switch result {
            case .success(let allDishes):
               
                hud.dismiss()
                
                self?.categories = allDishes.categorias ?? []
                self?.populars = allDishes.populares ?? []
                self?.specials = allDishes.especiales ?? []
                
                self?.categoryCollectionView.reloadData()
                self?.popularCollectionView.reloadData()
                self?.specialsCollectionView.reloadData()
                
            case .failure(let error):
                print("el error es: \(error.localizedDescription) ")
                
                let hud2 = JGProgressHUD(style: .dark)
                hud2.indicatorView = JGProgressHUDErrorIndicatorView() // Usa un ícono de error
                hud2.textLabel.text = "Error"
                hud2.show(in: self!.view)
                hud2.dismiss(afterDelay: 2.0)
                hud.dismiss()

            }
        }
     }
    
    private func registerCells(){
        
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        
        specialsCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
        
        
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case categoryCollectionView:
            categories.count
            
        case popularCollectionView:
            populars.count
        
        case specialsCollectionView:
            specials.count
            
        default:0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView{
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.setup(category: categories[indexPath.row])
            return cell
            
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as! DishPortraitCollectionViewCell
            cell.setup(dish: populars[indexPath.row])
            return cell
            
        case specialsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as! DishLandscapeCollectionViewCell
            cell.setup(dish: specials[indexPath.row])
            return cell
            
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let controller = ListDishesViewController.instantiate()
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }else{
            let controller = DishDetailViewController.instantiate()
            
            controller.dish = collectionView == popularCollectionView ? populars[indexPath.row] : specials[indexPath.row]
            
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
