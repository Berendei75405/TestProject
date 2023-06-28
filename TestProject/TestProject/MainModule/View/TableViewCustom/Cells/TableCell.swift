//
//  TableCell.swift
//  TestProject
//
//  Created by user on 27.06.2023.
//

import UIKit

class TableCell: UITableViewCell {
    static let identifier = "TableCell"
    
    //MARK: - nameLabel
    private var nameLabel: UILabel = {
        var lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false

        lab.textColor = .black
        lab.lineBreakMode = .byWordWrapping
        lab.numberOfLines = 2
        lab.font = .systemFont(ofSize: 20)
        lab.text = "Пекарни и кондитерские"
        
        return lab
    }()
    
    //MARK: - categoriesImageView
    private var categoriesImageView: UIImageView = {
        var imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        //MARK: - categoriesImageView constraint
        contentView.addSubview(categoriesImageView)
        NSLayoutConstraint.activate([
            categoriesImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            categoriesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoriesImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoriesImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        //MARK: - nameLabel constraint
        categoriesImageView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: categoriesImageView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: categoriesImageView.leadingAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 160),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - configurate
    func configurate(name: String, imageData: Data) {
        self.nameLabel.text = name
        self.categoriesImageView.image = UIImage(data: imageData)
    }
    
}
