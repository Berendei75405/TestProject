//
//  ViewSelectProduct.swift
//  TestProject
//
//  Created by user on 30.06.2023.
//

import UIKit

protocol ViewSelectProductDelegate: AnyObject {
    func addBusket(dish: Dish, image: Data)
}

final class ViewSelectProduct: UIViewController {
    
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(backTapAction(sender:)))
    private var dish: Dish!
    private var image: Data!
    
    weak var delegate: ViewSelectProductDelegate?
    
    //MARK: - mainView
    private var mainView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
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
        lab.textColor = .black
        lab.font = .systemFont(ofSize: 16)
        
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
    
    //MARK: - descriptionLabel
    private lazy var descriptionLabel: UILabel = {
        var lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.textColor = .gray
        lab.lineBreakMode = .byWordWrapping
        lab.numberOfLines = 12
        lab.font = .systemFont(ofSize: 10.5)
        if self.view.frame.height > 668 {
            lab.font = .systemFont(ofSize: 13)
        }
        
        return lab
    }()
    
    //MARK: - buyButton
    private var buyButton: UIButton = {
        var button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить в корзину", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2544889748, green: 0.4875386357, blue: 0.9033587575, alpha: 1)
        button.tintColor = .white
        
        return button
    }()
    
    //MARK: - likeView
    private var likeView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.frame.size = CGSize(width: 40, height: 40)
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    //MARK: - likeView
    private var xView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.frame.size = CGSize(width: 40, height: 40)
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    //MARK: - likeButton
    private var likeButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "like"), for: .normal)
        button.backgroundColor = .white
        button.frame.size = CGSize(width: 35, height: 35)
        button.tintColor = .white
        
        return button
    }()
    
    //MARK: - xButton
    private var xButton: UIButton = {
        var button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "x"), for: .normal)
        button.backgroundColor = .white
        button.frame.size = CGSize(width: 35, height: 35)
        button.contentMode = .scaleAspectFill
        button.tintColor = .black
        
        return button
    }()
    
    
    //MARK: - grayView
    private var grayView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = #colorLiteral(red: 0.9782746434, green: 0.9749353528, blue: 0.9687902331, alpha: 1)
        
        return view
    }()
    
    override func viewDidLoad() {
        setViews()
    }
    
    //MARK: - setViews
    private func setViews() {
        self.view.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        //MARK: - constraints mainView
        self.view.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.heightAnchor.constraint(equalToConstant: view.frame.height/1.8),
            mainView.widthAnchor.constraint(equalToConstant: view.frame.width/1.1)
        ])
        
        //MARK: - grayView constraints
        mainView.addSubview(grayView)
        NSLayoutConstraint.activate([
            grayView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 15),
            grayView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 15),
            grayView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15),
            grayView.heightAnchor.constraint(equalTo: mainView.heightAnchor, multiplier: 0.4)
        ])
        
        //MARK: - nameLabel constraints
        mainView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: grayView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: grayView.trailingAnchor),
        ])
        
        //MARK: - priceLabel constraints
        mainView.addSubview(priceLabel)
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            priceLabel.leadingAnchor.constraint(equalTo: grayView.leadingAnchor),
        ])
        
        //MARK: - weightLabel constraints
        mainView.addSubview(weightLabel)
        NSLayoutConstraint.activate([
            weightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            weightLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
        ])
        
        //MARK: - buyButton constraints
        mainView.addSubview(buyButton)
        buyButton.addTarget(self, action: #selector(buyButtonAction), for: .touchUpInside)
        NSLayoutConstraint.activate([
            buyButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10),
            buyButton.leadingAnchor.constraint(equalTo: grayView.leadingAnchor),
            buyButton.trailingAnchor.constraint(equalTo: grayView.trailingAnchor),
            buyButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        //MARK: - descriptionLabel constraints
        mainView.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 3),
            descriptionLabel.leadingAnchor.constraint(equalTo: grayView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: grayView.trailingAnchor)
        ])
        
        //MARK: - dishImageView constraint
        grayView.addSubview(dishImageView)
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 10),
            dishImageView.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 10),
            dishImageView.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -10),
            dishImageView.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -10)
        ])
        
        //MARK: - xButton constraints
        grayView.addSubview(xView)
        NSLayoutConstraint.activate([
            xView.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 10),
            xView.trailingAnchor.constraint(equalTo: grayView.trailingAnchor, constant: -10),
            xView.heightAnchor.constraint(equalToConstant: 40),
            xView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        //MARK: - xButton constraints
        grayView.addSubview(likeView)
        NSLayoutConstraint.activate([
            likeView.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 10),
            likeView.trailingAnchor.constraint(equalTo: xView.leadingAnchor, constant: -10),
            likeView.heightAnchor.constraint(equalToConstant: 40),
            likeView.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        //MARK: - xButton constraints
        xButton.addTarget(self, action: #selector(backTap), for: .touchUpInside)
        xView.addSubview(xButton)
        NSLayoutConstraint.activate([
            xButton.centerXAnchor.constraint(equalTo: xView.centerXAnchor),
            xButton.centerYAnchor.constraint(equalTo: xView.centerYAnchor),
            xButton.widthAnchor.constraint(equalToConstant: 30),
            xButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        //MARK: - xButton constraints
        likeView.addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.centerXAnchor.constraint(equalTo: likeView.centerXAnchor),
            likeButton.centerYAnchor.constraint(equalTo: likeView.centerYAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 30),
            likeButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    //MARK: - configurate
    func configurate(dish: Dish, image: Data) {
        self.dishImageView.image = UIImage(data: image)
        self.nameLabel.text = dish.name
        self.priceLabel.text = "\(dish.price) ₽"
        self.weightLabel.text = " · \(dish.weight)"
        self.descriptionLabel.text = dish.description
        self.dish = dish
        self.image = image
    }

    //MARK: - backTap
    @objc private func backTap() {
        dismiss(animated: false)
    }
    
    //MARK: - buyButtonAction
    @objc private func buyButtonAction() {
        self.delegate?.addBusket(dish: dish, image: image)
    }
    
    //MARK: - backTapAction
    @objc private func backTapAction(sender: UITapGestureRecognizer) {
        let possition = sender.location(in: self.view)
        if (possition.y > mainView.frame.maxY || possition.y < mainView.frame.minY) || (possition.x > mainView.frame.maxX || possition.x < mainView.frame.minX){
            dismiss(animated: false)
        }
    }
    
}
