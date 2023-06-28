//
//  TableViewCustom.swift
//  TestProject
//
//  Created by user on 27.06.2023.
//

import UIKit

//состояния таблицы
enum TableViewState {
    case initial
    case failure
    case success
}

class TableViewCustom: UITableView {
    //MARK: - Состояние таблицы
    var tableState: TableViewState = .initial {
        didSet {
            reloadData()
        }
    }
    
    weak var vc: MainViewController!
    
    //MARK: - override init
    override init(frame: CGRect, style: UITableView.Style) {
        super .init(frame: .zero, style: .insetGrouped)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = .none
        self.backgroundColor = .white
        
        self.register(TableCell.self, forCellReuseIdentifier: TableCell.identifier)
        
        self.delegate = self
        self.dataSource = self
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - createConstraintsForTable
    func createConstraintsForTable(view: UIView) {
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(
                equalTo: view.topAnchor),
            
            self.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            
            self.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            
            self.bottomAnchor.constraint(
                equalTo: view.bottomAnchor)
        ])
    }
    
}

extension TableViewCustom: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vc.viewModel.categories?.сategories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier) as? TableCell {
            let cat = vc.viewModel.categories?.сategories[indexPath.row]
            
            cell.selectionStyle = .none
            cell.configurate(name: cat?.name ?? "", imageData: vc.viewModel.imageArray[indexPath.row])
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vc.viewModel.coordinator.showDetailModule()
    }
    
}
