//
//  DishCell.swift
//  TestProject
//
//  Created by user on 29.06.2023.
//

import UIKit

final class DishCell: UICollectionViewCell {
    static let identifier = "DishCell"
    
    //MARK: - mainView
    private lazy var mainView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.frame.size = CGSize(width: contentView.frame.width, height: contentView.frame.height)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.backgroundColor = #colorLiteral(red: 0.9782746434, green: 0.9749353528, blue: 0.9687902331, alpha: 1)
        
        return view
    }()
    
    //MARK: - nameLabel
    private var nameLabel: UILabel = {
        var lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false

        lab.textColor = .black
        lab.lineBreakMode = .byWordWrapping
        lab.numberOfLines = 2
        lab.font = .systemFont(ofSize: 13)
        lab.text = "Салат по восточному"
        lab.adjustsFontSizeToFitWidth = true
        lab.textAlignment = .left
        
        return lab
    }()
    
    //MARK: - dishImageView
    private var dishImageView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        //MARK: - mainView constraint
        contentView.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
        
        //MARK: - dishImageView
        mainView.addSubview(dishImageView)
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            dishImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 5),
            dishImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -5),
            dishImageView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -5)
        ])
        
        //MARK: - nameLabel
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: dishImageView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    func configurateCell(name: String, imageData: Data) {
        nameLabel.text = name
        self.dishImageView.image = UIImage(data: imageData)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
