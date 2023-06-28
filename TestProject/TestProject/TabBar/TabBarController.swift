//
//  TabBarController.swift
//  TestProject
//
//  Created by user on 28.06.2023.
//
import UIKit

class TabBarController: UITabBarController {
    
    var coordinator: MainCoordinatorProtocol!
    
    //MARK: - mainView
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        return view
    }()
    
    //MARK: - homeImageView
    private let homeImageView: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "homeBlue")
        
        return img
    }()
    
    //MARK: - homeButton
    private lazy var homeButton: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.addTarget(self, action: #selector(homeAction(sender:)), for: .touchUpInside)
        
        return but
    }()
    
    //MARK: - searchImageView
    private let searchImageView: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "search")
        img.tintColor = .white
        
        return img
    }()
    
    //MARK: - searchButton
    private lazy var searchButton: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.addTarget(self, action: #selector(searchAction(sender:)), for: .touchUpInside)
        
        return but
    }()
    
    //MARK: - shopImageView
    private let shopImageView: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "shop")
        img.tintColor = .white
        
        return img
    }()
    
    //MARK: - shopButton
    private lazy var shopButton: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.addTarget(self, action: #selector(shopAction(sender:)), for: .touchUpInside)
        
        return but
    }()
    
    //MARK: - personImageView
    private let personImageView: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "person")
        img.tintColor = .white
        
        return img
    }()
    
    //MARK: - personButton
    private lazy var personButton: UIButton = {
        var but = UIButton()
        but.translatesAutoresizingMaskIntoConstraints = false
        but.addTarget(self, action: #selector(personAction(sender:)), for: .touchUpInside)
        
        return but
    }()
    

    //MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        constraints()
    }
    
    //MARK: - constraints
    private func constraints() {
        self.tabBar.addSubview(mainView)

        //MARK: - mainView constraint
        mainView.frame = self.tabBar.frame
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: self.tabBar.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: self.tabBar.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: self.tabBar.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: self.tabBar.bottomAnchor)
        ])
        
        //MARK: - homeImageView constraint
        mainView.addSubview(homeImageView)
        NSLayoutConstraint.activate([
            homeImageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            homeImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 31),
            homeImageView.widthAnchor.constraint(equalToConstant: 48),
            homeImageView.heightAnchor.constraint(equalToConstant: 49)
        ])
        
        //MARK: - mainView constraint
        mainView.addSubview(homeButton)
        NSLayoutConstraint.activate([
            homeButton.topAnchor.constraint(equalTo: self.tabBar.topAnchor),
            homeButton.leadingAnchor.constraint(equalTo: self.tabBar.leadingAnchor, constant: 31),
            homeButton.widthAnchor.constraint(equalToConstant: 48),
            homeButton.heightAnchor.constraint(equalToConstant: 49)
        ])
        
        //MARK: - searchImageView constraint
        mainView.addSubview(searchImageView)
        NSLayoutConstraint.activate([
            searchImageView.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            searchImageView.leadingAnchor.constraint(equalTo: homeImageView.trailingAnchor, constant: 41),
            searchImageView.widthAnchor.constraint(equalToConstant: 48),
            searchImageView.heightAnchor.constraint(equalToConstant: 49)
        ])
        
        //MARK: - searchButton constraint
        mainView.addSubview(searchButton)
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            searchButton.leadingAnchor.constraint(equalTo: homeImageView.trailingAnchor, constant: 41),
            searchButton.widthAnchor.constraint(equalToConstant: 48),
            searchButton.heightAnchor.constraint(equalToConstant: 49)
        ])
        
        //MARK: - shopImageView constraint
        mainView.addSubview(shopImageView)
        NSLayoutConstraint.activate([
            shopImageView.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            shopImageView.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: 41),
            shopImageView.widthAnchor.constraint(equalToConstant: 48),
            shopImageView.heightAnchor.constraint(equalToConstant: 49)
        ])
        
        //MARK: - shopButton constraint
        mainView.addSubview(shopButton)
        NSLayoutConstraint.activate([
            shopButton.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            shopButton.leadingAnchor.constraint(equalTo: searchImageView.trailingAnchor, constant: 41),
            shopButton.widthAnchor.constraint(equalToConstant: 48),
            shopButton.heightAnchor.constraint(equalToConstant: 49)
        ])
        
        //MARK: - personImageView constraint
        mainView.addSubview(personImageView)
        NSLayoutConstraint.activate([
            personImageView.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            personImageView.leadingAnchor.constraint(equalTo: shopImageView.trailingAnchor, constant: 41),
            personImageView.widthAnchor.constraint(equalToConstant: 48),
            personImageView.heightAnchor.constraint(equalToConstant: 49)
        ])
        
        //MARK: - personButton constraint
        mainView.addSubview(personButton)
        NSLayoutConstraint.activate([
            personButton.topAnchor.constraint(equalTo: self.mainView.topAnchor),
            personButton.leadingAnchor.constraint(equalTo: shopImageView.trailingAnchor, constant: 41),
            personButton.widthAnchor.constraint(equalToConstant: 48),
            personButton.heightAnchor.constraint(equalToConstant: 49)
        ])
        
    }
    
    //MARK: - homeAction
    @objc private func homeAction(sender: UIButton) {
        coordinator.popToRoot()
        homeImageView.image = UIImage(named: "homeBlue")
        searchImageView.image = UIImage(named: "search")
        shopImageView.image = UIImage(named: "shop")
        personImageView.image = UIImage(named: "person")
    }
    
    //MARK: - searchAction
    @objc private func searchAction(sender: UIButton) {
        homeImageView.image = UIImage(named: "home")
        searchImageView.image = UIImage(named: "searchBlue")
        shopImageView.image = UIImage(named: "shop")
        personImageView.image = UIImage(named: "person")
    }
    
    //MARK: - shopAction
    @objc private func shopAction(sender: UIButton) {
        homeImageView.image = UIImage(named: "home")
        searchImageView.image = UIImage(named: "search")
        shopImageView.image = UIImage(named: "shopBlue")
        personImageView.image = UIImage(named: "person")
    }
    
    //MARK: - personAction
    @objc private func personAction(sender: UIButton) {
        homeImageView.image = UIImage(named: "home")
        searchImageView.image = UIImage(named: "search")
        shopImageView.image = UIImage(named: "shop")
        personImageView.image = UIImage(named: "personBlue")
    }
}
