//
//  BasketViewController.swift
//  TestProject
//
//  Created by user on 02.07.2023.
//

import UIKit

class BasketViewController: UIViewController {
    var viewModel: BasketViewModelProtocol!
    
    //MARK: - tableView
    var tableView: UITableView = {
        var table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .white
        
        table.register(BasketCell.self, forCellReuseIdentifier: BasketCell.identifier)
        
        return table
    }()
    
    //MARK: - buyButton
    private var buyButton: UIButton = {
        var button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Оплатить 2 004 ₽", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2544889748, green: 0.4875386357, blue: 0.9033587575, alpha: 1)
        button.tintColor = .white
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarMain()
        setContraints()
    }
    
    //MARK: - setContraints
    private func setContraints() {
        view.backgroundColor = .white
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(buyButton)
        NSLayoutConstraint.activate([
            buyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buyButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: view.frame.height/2.8),
            buyButton.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            buyButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.identifier) as?
            BasketCell {
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
