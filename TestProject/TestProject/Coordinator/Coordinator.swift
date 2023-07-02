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
    func showDetailModule(categorySelect: String)
    func popToRoot()
    func initailViewController()
    func createBasketModule() -> UIViewController
    func showBasketModule()
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
        let coordinator = self
        
        view.viewModel = viewModel
        
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
        let viewSelected = ViewSelectProduct()
        let coordinator = self
        
        view.viewModel = viewModel
        view.viewSelect = viewSelected
        
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
    func showDetailModule(categorySelect: String) {
        if let tabBar = tabBar {
            let view = createDetailModule()
            view.navigationItem.hidesBackButton = true
            
            
            guard let nvc = tabBar.viewControllers?.first as? UINavigationController else {return}
            guard let view = view as? DishViewController else {return}
            view.categorySelect = categorySelect
            nvc.pushViewController(view, animated: true)
        }
    }
    
    //MARK: - popToRoot
    func popToRoot() {
        if let tabBar = tabBar {
            guard let nvc = tabBar.viewControllers?.first as? UINavigationController else {return}
            
            nvc.popToRootViewController(animated: true)
        }
    }
    
    //MARK: - createBasketModule
    func createBasketModule() -> UIViewController {
        let view = BasketViewController()
        let viewModel = BasketViewModel()
        let coordinator = self
        
        view.viewModel = viewModel
        viewModel.coordinator = coordinator
        
        return view
    }
    
    //MARK: - createBasketModule
    func showBasketModule() {
        if let tabBar = tabBar {
            let view = createBasketModule()
            view.navigationItem.hidesBackButton = true
            
            guard let nvc = tabBar.viewControllers?.first as? UINavigationController else {return}
            guard let view = view as? BasketViewController else {return}
            
            nvc.pushViewController(view, animated: true)
        }
    }
}
