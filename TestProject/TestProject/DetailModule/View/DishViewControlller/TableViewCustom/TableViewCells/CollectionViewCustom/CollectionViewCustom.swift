//
//  CollectionViewCustom.swift
//  TestProject
//
//  Created by user on 29.06.2023.
//

import UIKit

class CollectionViewCustom: UICollectionView {
    weak var vc: DishViewController!
    
    private lazy var width = UIScreen.main.bounds.size.width/3.5
    private lazy var height = UIScreen.main.bounds.size.height/5

    var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
        
        return layout
    }()
    
    //MARK: - override init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super .init(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsVerticalScrollIndicator = false
        self.collectionViewLayout = collectionViewFlowLayout
        self.decelerationRate = .normal
        self.collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
        
        self.register(DishCell.self, forCellWithReuseIdentifier: DishCell.identifier)
        
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - createConstraintsForCollection
    func createConstraintsForCollection(view: UIView) {
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(
                equalTo: view.topAnchor),
            
            self.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            
            self.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            self.bottomAnchor.constraint(
                equalTo: view.bottomAnchor)
        ])
    }
}

extension CollectionViewCustom: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return vc.viewModel.getDishSorted().dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCell.identifier, for: indexPath) as? DishCell {
            let dishArray = vc.viewModel.getDishSorted().dishes[indexPath.row]
            let imageArray = vc.viewModel.imageArray[dishArray.id]
            
            cell.configurateCell(name: dishArray.name, imageData: imageArray ?? Data())
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dishArray = vc.viewModel.getDishSorted().dishes[indexPath.row]
        let imageArray = vc.viewModel.imageArray[dishArray.id]
        
        //vc.viewModel.coordinator.tabBar?.show(vc.viewSelect, sender: nil)
        
        
//        vc.viewSelect.configurate(image: imageArray ?? Data(),
//                                  name: dishArray.name, price: dishArray.price, weight: dishArray.weight,
//                                  description: dishArray.description)
        
    }
}
