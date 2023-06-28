//
//  ViewController.swift
//  TestProject
//
//  Created by user on 27.06.2023.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    var tableView: TableViewCustom = TableViewCustom(frame: .zero, style:  .insetGrouped)
    var viewModel: MainViewModelProtocol!
    private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.createConstraintsForTable(view: self.view)
        viewModel.fetchCategories()
        updateTableState()
    }
    
    private func updateTableState() {
        viewModel.updateTableState.sink { [self] state in
            self.tableView.tableState = state
        }.store(in: &cancellable)
    }


}

