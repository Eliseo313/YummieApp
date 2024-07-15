//
//  HomeViewController.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 05/07/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    @IBOutlet weak var popularCollectionView: UICollectionView!
    
    @IBOutlet weak var specialsCollectionView: UICollectionView!
    
    var categories: [DishCategory] = [
        .init(id: "id1", name: "Comida Mexicana", image: "https://picsum.photos/100/200"),
        .init(id: "id2", name: "Comida Italiana", image: "https://picsum.photos/100/200"),
        .init(id: "id3", name: "Comida China", image: "https://picsum.photos/100/200"),
        .init(id: "id4", name: "Comida Tailandesa", image: "https://picsum.photos/100/200"),
        .init(id: "id5", name: "Comida Japonesa", image: "https://picsum.photos/100/200")
    ]
    var populars : [Dish] = [
        .init(id: "id1", name: "Morisqueta", description: "La más pedida!", image: "https://picsum.photos/100/200", calories: 700),
        .init(id: "id2", name: "Pechuga asada", description: "Delicioso!", image: "https://picsum.photos/100/200", calories: 300),
        .init(id: "id3", name: "Mole", description: "Especialidad de la casa", image: "https://picsum.photos/100/200", calories: 500)
    ]
    
    var specials : [Dish] = [
        .init(id: "id1", name: "Morisqueta", description: "Mi platillo favorito", image: "https://picsum.photos/100/200", calories: 700),
        .init(id: "id2", name: "Enchiladas", description: "Al estilo Michoacán",
              image: "https://picsum.photos/100/200", calories: 1000),
        .init(id: "id2", name: "Pozole Rojo", description: "El platillo tipico que necesitas",
              image: "https://picsum.photos/100/200", calories: 8000)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        specialsCollectionView.dataSource = self
        
        registerCells()
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
}
