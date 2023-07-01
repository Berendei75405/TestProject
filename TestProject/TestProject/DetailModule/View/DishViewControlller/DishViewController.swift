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
    var viewSelect = ViewSelectProduct()
    var categorySelect = ""
    var tableView: DishTableView!
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        viewModel.fetchDish()
        tableView.createConstraintsForTable(view: view)
        setNavigationBarDetail()
        viewSelect.setViews(mainView: self.view)
        updateCollectionState()
    }
    
    //MARK: - updateCollectionState
    private func updateCollectionState() {
        viewModel.updateTableState.sink { [weak self] state in
            self?.tableView.tableState = state
        }.store(in: &cancellable)
    }

}

//MARK: - extension
extension DishViewController {
    func setNavigationBarDetail() {
        let viewTitle = UIView(frame: .zero)
        viewTitle.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        viewTitle.clipsToBounds = true
        
        let backButton = UIButton()
        backButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTap), for: .touchUpInside)
        
        let profileImageView = UIImageView(frame: CGRect(x: view.frame.width - view.frame.width/5, y: -2, width: 44, height: 44))
        profileImageView.image = UIImage(named: "face")
        profileImageView.layer.cornerRadius = 22
        profileImageView.clipsToBounds = true
        
        let categorylLabel = UILabel(frame: .zero)
        categorylLabel.frame = CGRect(x: 44, y: 0, width: viewTitle.frame.width - backButton.frame.width - 75, height: 44)
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
        viewModel.coordinator.popToRoot()
    }
}
