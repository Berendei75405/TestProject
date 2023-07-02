//
//  DishTableCell.swift
//  TestProject
//
//  Created by user on 30.06.2023.
//

import UIKit

protocol DishTableViewCellDelegateProtocol: AnyObject {
    func showDish(dish: Dish, image: Data)
}

final class DishTableCell: UITableViewCell {
    
    static let identifier = "DishTableCell"
    private lazy var width = UIScreen.main.bounds.size.width/3.5
    private lazy var height = UIScreen.main.bounds.size.height/5
    weak var delegate: DishTableViewCellDelegateProtocol?
    
    private var imageDict: [Int: Data] = [:]
    private var dishArray: DishArray = .init(dishes: [])
    
    //MARK: - collectionViewFlowLayout
    private var collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 15)
        
        return layout
    }()
    
    //MARK: - collectionView
    lazy var collectionView: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        contentView.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsVerticalScrollIndicator = false
        collection.decelerationRate = .normal
        self.collectionViewFlowLayout.itemSize = CGSize(width: self.width,
                                                        height: self.height)
        
        collection.register(DishCell.self,
                            forCellWithReuseIdentifier: DishCell.identifier)
        
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        //MARK: - collectionView constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    //MARK: - configurate
    func configurate(imageDict: [Int: Data], dishArray: DishArray) {
        self.imageDict = imageDict
        self.dishArray = dishArray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - extensions
extension DishTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dishArray.dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCell.identifier, for: indexPath) as? DishCell {
            cell.configurateCell(name: self.dishArray.dishes[indexPath.row].name,
                                 imageData: self.imageDict[dishArray.dishes[indexPath.row].id] ?? Data())
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //delegate
        self.delegate?.showDish(dish: self.dishArray.dishes[indexPath.row],
                                image: self.imageDict[dishArray.dishes[indexPath.row].id] ?? Data())

    }
    
}
