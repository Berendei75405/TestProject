//
//  DishViewController.swift
//  TestProject
//
//  Created by user on 28.06.2023.
//

import UIKit
import Combine

class DishViewController: UIViewController {
    var viewModel: DishViewModelProtocol!
    var viewSelect: ViewSelectProduct!
    var categorySelect = ""
    //обновление таблицы
    var tableReload: Bool = false {
        didSet {
            tableView.reloadRows(at: [IndexPath(row: 1, section: .zero)], with: .automatic)
            let cell = tableView.cellForRow(at: IndexPath(row: 1, section: .zero)) as? DishTableCell
            cell?.collectionView.reloadData()
        }
    }
    //MARK: - tableView
    private lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        
        tableView.register(FilterTableCell.self, forCellReuseIdentifier: FilterTableCell.identifier)
        tableView.register(DishTableCell.self, forCellReuseIdentifier: DishTableCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        viewModel.fetchDish()
        setNavigationBarDetail()
        viewSelect.delegate = self
        updateTableState()
        createConstraintsForTable()
    }
    
    //MARK: - updateTableState
    private func updateTableState() {
        viewModel.updateTableState.sink { [weak self] state in
            self?.tableReload = state
        }.store(in: &cancellable)
    }
    
    //MARK: - createConstraintsForTable
    private func createConstraintsForTable() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.topAnchor),
            
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor)
        ])
    }

}

//MARK: - extensions
extension DishViewController: UITableViewDelegate, UITableViewDataSource, DishTableViewCellDelegateProtocol, ViewSelectProductDelegate {
    func addBusket(dish: Dish, image: Data) {
        self.viewModel.appendDish(dish: dish, image: image, key: "dish")
    }
    
    //MARK: - DishTableViewCellDelegateProtocol
    func showDish(dish: Dish, image: Data) {
        self.viewSelect.modalPresentationStyle = .overCurrentContext
        self.viewModel.coordinator.tabBar?.present(self.viewSelect, animated: false)
        //передаем данные для экрана
        self.viewSelect.configurate(dish: dish, image: image)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == .zero {
            if let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableCell.identifier) as? FilterTableCell {
                
                cell.selectionStyle = .none
                cell.configurate(titleArray: self.viewModel.titleArray)
                cell.filterPickerView.tapOnButton.sink { [unowned self] teg in
                    self.viewModel.sortDescriptor = teg
                }.store(in: &cancellable)
                
                return cell
            }
        } else if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: DishTableCell.identifier) as? DishTableCell {
                
                cell.selectionStyle = .none
                cell.configurate(imageDict: self.viewModel.imageArray, dishArray: self.viewModel.getDishSorted())
                cell.delegate = self
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == .zero {
            return 40
        } else {
            let countCell = CGFloat((self.viewModel.dishArray?.dishes.count ?? .zero)/3)
            let height = UIScreen.main.bounds.size.height/5 + 10
            return countCell * height
        }
    }
}

extension DishViewController {
    func setNavigationBarDetail() {
        let viewTitle = UIView(frame: .zero)
        viewTitle.frame = CGRect(x: .zero,
                                 y: .zero,
                                 width: view.frame.width,
                                 height: 44)
        viewTitle.clipsToBounds = true
        
        let backButton = UIButton()
        backButton.frame = CGRect(x: .zero,
                                  y: .zero,
                                  width: 44,
                                  height: 44)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        
        let profileImageView = UIImageView(frame: CGRect(
            x: view.frame.width - view.frame.width/5,
            y: -2,
            width: 44,
            height: 44))
        profileImageView.image = UIImage(named: "face")
        profileImageView.layer.cornerRadius = 22
        profileImageView.clipsToBounds = true
        
        let categorylLabel = UILabel(frame: .zero)
        categorylLabel.frame = CGRect(x: 44,
                                      y: .zero,
                                      width: viewTitle.frame.width - backButton.frame.width - 75,
                                      height: 44)
        categorylLabel.text = "\(categorySelect)"
        categorylLabel.font = .boldSystemFont(ofSize: 16)
        categorylLabel.textAlignment = .center
        categorylLabel.textColor = .black
        
        viewTitle.addSubview(backButton)
        viewTitle.addSubview(categorylLabel)
        viewTitle.addSubview(profileImageView)
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.titleView = viewTitle
        
    }
    
    @objc private func backButtonTap() {
        self.viewModel.coordinator.popToRoot()
    }
}
