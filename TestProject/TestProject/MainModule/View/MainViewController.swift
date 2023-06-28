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
        viewModel.fetchCategories()
        updateTableState()
        tableView.createConstraintsForTable(view: self.view)
        setNavigationBarMain()
    }
    
    private func updateTableState() {
        viewModel.updateTableState.sink { [self] state in
            self.tableView.tableState = state
        }.store(in: &cancellable)
    }

}

extension UIViewController {
    func setNavigationBarMain() {
        let viewTitle = UIView(frame: .zero)
        viewTitle.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 44)
        viewTitle.clipsToBounds = true
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, YYYY"
        formatter.locale = Locale(identifier: "ru_RU")
        let dateString = formatter.string(from: currentDate).capitalized
        
        let imageView = UIImageView(image: UIImage(named: "location"))
        imageView.frame = CGRect(x: 0, y: 5, width: 30, height: 20)
        imageView.contentMode = .scaleAspectFit
        
        let cityLabel = UILabel(frame: CGRect(x: 30, y: 1, width: 200, height: 20))
        cityLabel.text = "Санкт-Петербург"
        cityLabel.textColor = .black
        cityLabel.font = .boldSystemFont(ofSize: 18)
        
        let dateLabel = UILabel(frame: CGRect(x: 30, y: 20, width: 150, height: 20))
        dateLabel.text = dateString
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .gray
        
        let profileImageView = UIImageView(frame: CGRect(x: view.frame.width - 75, y: 0, width: 44, height: 44))
        profileImageView.image = UIImage(named: "face")
        profileImageView.layer.cornerRadius = 22
        profileImageView.clipsToBounds = true
        
        
        viewTitle.addSubview(imageView)
        viewTitle.addSubview(cityLabel)
        viewTitle.addSubview(dateLabel)
        viewTitle.addSubview(profileImageView)
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.titleView = viewTitle
    }
}

