//
//  Coordinator.swift
//  TestProject
//
//  Created by user on 28.06.2023.
//

import UIKit

protocol MainCoordinatorProtocol {
    var navigationController: UINavigationController? {get}
    func createModule() -> UIViewController
    func initailViewController()
}

class Coordinator: MainCoordinatorProtocol {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    
    //MARK: - createModule
    func createModule() -> UIViewController {
        let view = MainViewController()
        let viewModel = MainViewModel()
        let tableView = TableViewCustom()
        let router = self
        
        view.viewModel = viewModel
        view.tableView = tableView
        tableView.vc = view
        
        viewModel.coordinator = router
        
        return view
    }
    //MARK: - initailViewController
    func initailViewController() {
        if let navigationController = navigationController {
            let view = createModule()
            
            navigationController.viewControllers = [view]
        }
    }
}
