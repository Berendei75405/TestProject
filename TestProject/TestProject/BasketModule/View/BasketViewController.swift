//
//  BasketViewController.swift
//  TestProject
//
//  Created by user on 02.07.2023.
//

import UIKit
import Combine

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
    
    //MARK: - cancellable
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarMain()
        setContraints()
        updateButton()
        configurateButton()
    }
    
    //MARK: - updateButton
    private func updateButton() {
        self.viewModel.reloadView.sink { [weak self] bool in
            if bool == true {
                self?.configurateButton()
            } else {
                self?.configurateButton()
                self?.tableView.reloadData()
            }
        }.store(in: &cancellable)
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
    
    private func configurateButton() {
        if self.viewModel.getModel().count == .zero {
            UIView.animate(withDuration: 0.3) {
                self.buyButton.alpha = 0
            }
        } else {
            self.buyButton.alpha = 1
            self.buyButton.setTitle("Оплатить \(self.viewModel.returnTotalPrice()) ₽", for: .normal)
        }
    }

    
}

extension BasketViewController: UITableViewDelegate,
                                UITableViewDataSource,
                                CustomStepperDelegateProtocol {
    func decrease(tag: Int) {
        self.viewModel.removeModel(index: tag)
    }
    
    func increaseButton(tag: Int) {
        self.viewModel.appendModel(index: tag)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getModel().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: BasketCell.identifier) as?
            BasketCell {
            
            let dish = self.viewModel.getModel()
            cell.stepper.tag = indexPath.row
            cell.selectionStyle = .none
            cell.config(image: dish[indexPath.row].image,
                        name: dish[indexPath.row].name,
                        weight: dish[indexPath.row].weight,
                        price: dish[indexPath.row].price,
                        count: dish[indexPath.row].count)
            cell.stepper.delegate = self
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
