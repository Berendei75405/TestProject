//
//  DishTableView.swift
//  TestProject
//
//  Created by user on 30.06.2023.
//

import UIKit
import Combine

class DishTableView: UITableView {
    //MARK: - Состояние таблицы
    var tableState: TableViewState = .initial {
        didSet {
            self.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
            let cell = self.cellForRow(at: IndexPath(row: 1, section: 0)) as? DishTableCell
            cell?.collectionView.reloadData()
        }
    }
    
    weak var vc: DishViewController!
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - override init
    override init(frame: CGRect, style: UITableView.Style) {
        super .init(frame: .zero, style: .plain)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = .none
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = .white
        
        self.register(FilterTableCell.self, forCellReuseIdentifier: FilterTableCell.identifier)
        self.register(DishTableCell.self, forCellReuseIdentifier: DishTableCell.identifier)
        
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

extension DishTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableCell.identifier) as? FilterTableCell {
                

                cell.selectionStyle = .none
                cell.filterPickerView.tapOnButton.sink { [unowned self] teg in
                    
                    self.vc.viewModel.sortDescriptor = teg
                    self.vc.viewModel.updateTableState.send(.success)
                    
                }.store(in: &cancellable)
                cell.configurate(titleArray: vc.viewModel.titleArray)
                
                return cell
            }
        } else if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: DishTableCell.identifier) as? DishTableCell {
                cell.collectionView.vc = vc
                
                cell.selectionStyle = .none
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 40
        } else {
            let countCell = CGFloat((vc.viewModel.getDishSorted().dishes.count)/3)
            let height = UIScreen.main.bounds.size.height/5 + 10
            return 100 * height
        }
    }
}
