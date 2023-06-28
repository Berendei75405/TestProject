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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .red
        
        //MARK: - nameLabel constraint
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 160),
            nameLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - configurate
    func configurate(name: String) {
        self.nameLabel.text = name
    }
    
}
