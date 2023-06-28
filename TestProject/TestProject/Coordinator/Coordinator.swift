//
//  Coordinator.swift
//  TestProject
//
//  Created by user on 28.06.2023.
//

import UIKit

protocol MainCoordinatorProtocol {
    var tabBar: TabBarController? {get}
    func createModule() -> UIViewController
    func createDetailModule() -> UIViewController
    func showDetailModule()
    func popToRoot()
    func initailViewController()
}

class Coordinator: MainCoordinatorProtocol {
     var tabBar: TabBarController?
    
    init(tabBar: TabBarController) {
        self.tabBar = tabBar
        
    }
    
    //MARK: - createModule
    func createModule() -> UIViewController {
        let view = MainViewController()
        let viewModel = MainViewModel()
        let tableView = TableViewCustom()
        let coordinator = self
        
        
        view.viewModel = viewModel
        view.tableView = tableView
        tableView.vc = view
        
        if let tabBar = tabBar {
            tabBar.coordinator = coordinator
        }
        
        viewModel.coordinator = coordinator
        
        return view
    }
    
    //MARK: - createDetailModule
    func createDetailModule() -> UIViewController {
        let view = DishViewController()
        let viewModel = DishViewModel()
        let coordinator = self
        
        view.viewModel = viewModel
        viewModel.coordinator = coordinator
        
        return view
    }
    //MARK: - initailViewController
    func initailViewController() {
        if let tabBar = tabBar {
            let view = createModule()
        
            tabBar.viewControllers = [UINavigationController(rootViewController: view)]
        }
    }
    
    //MARK: - showDetailModule
    func showDetailModule() {
        if let tabBar = tabBar {
            let view = createDetailModule()
            view.navigationItem.hidesBackButton = true
            
            guard let nvc = tabBar.viewControllers?.first as? UINavigationController else {return}

            nvc.pushViewController(view, animated: true)
            //tabBar.selectedViewController?.show(view, sender: nil)
        }
    }
    
    //MARK: - popToRoot
    func popToRoot() {
        if let tabBar = tabBar {
            guard let nvc = tabBar.viewControllers?.first as? UINavigationController else {return}
            
            nvc.popToRootViewController(animated: true)
        }
    }
}
