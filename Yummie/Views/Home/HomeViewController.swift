//
//  HomeViewController.swift
//  Yummie
//
//  Created by Eliseo Adrian Cardenas Ortiz on 05/07/24.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categories: [DishCategory] = [
        .init(id: "id1", name: "Comida Mexicana", image: "https://picsum.photos/100/200"),
        .init(id: "id2", name: "Comida Italiana", image: "https://picsum.photos/100/200"),
        .init(id: "id3", name: "Comida China", image: "https://picsum.photos/100/200"),
        .init(id: "id4", name: "Comida Tailandesa", image: "https://picsum.photos/100/200"),
        .init(id: "id5", name: "Comida Japonesa", image: "https://picsum.photos/100/200")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Yummie"
        registerCells()
     }
    
    private func registerCells(){
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil),forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        cell.setup(category: categories[indexPath.row])
        return cell
    }
}
