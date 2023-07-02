//
//  BasketCel.swift
//  TestProject
//
//  Created by user on 02.07.2023.
//

import UIKit

final class BasketCell: UITableViewCell {
    
    static let identifier = "BasketCell"
    
    //MARK: - grayView
    private var grayView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = #colorLiteral(red: 0.9782746434, green: 0.9749353528, blue: 0.9687902331, alpha: 1)
        
        return view
    }()
    
    //MARK: - dishImageView
    private var dishImageView: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    //MARK: - priceLabel
    private var priceLabel: UILabel = {
        var lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "799 ₽"
        lab.font = .systemFont(ofSize: 15)
        lab.textColor = .black
        
        return lab
    }()
    
    //MARK: - nameLabel
    private var nameLabel: UILabel = {
        var lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Рыба с овощами и рисом"
        lab.lineBreakMode = .byWordWrapping
        lab.numberOfLines = 2
        lab.textColor = .black
        lab.font = .systemFont(ofSize: 15)
        
        return lab
    }()
    
    //MARK: - weightLabel
    private var weightLabel: UILabel = {
        var lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = " · 560г"
        lab.textColor = .gray
        lab.font = .systemFont(ofSize: 15)
        
        return lab
    }()
    
    //MARK: - stepper
    private var stepper: CustomStepper = {
        var step = CustomStepper(frame: .zero)
        step.translatesAutoresizingMaskIntoConstraints = false

        return step
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //MARK: - grayView constraint
        contentView.addSubview(grayView)
        NSLayoutConstraint.activate([
            grayView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            grayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            grayView.widthAnchor.constraint(equalToConstant: 70),
            grayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        //MARK: - dishImageView constraint
        grayView.addSubview(dishImageView)
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 10),
            dishImageView.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 10),
            dishImageView.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -10),
            dishImageView.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -10)
        ])
        
        //MARK: - nameLabel constraint
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: contentView.frame.width/1.4)
        ])
        
        //MARK: - priceLabel constraint
        contentView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: 10)
        ])
        
        //MARK: - weightLabel constraint
        contentView.addSubview(weightLabel)
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: priceLabel.topAnchor),
            weightLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 2)
        ])
        
        //MARK: - stepView constraints
        contentView.addSubview(stepper)
        NSLayoutConstraint.activate([
            stepper.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stepper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stepper.heightAnchor.constraint(equalToConstant: 35),
            stepper.widthAnchor.constraint(equalToConstant: 100)
        ])

        setupStepper()
    }
    
    private func setupStepper() {
        stepper.addTarget(self, action: #selector(stepperChangedValueAction), for: .valueChanged)
    }

    @objc private func stepperChangedValueAction(sender: CustomStepper) {
        print(sender)
        print(sender.currentValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
