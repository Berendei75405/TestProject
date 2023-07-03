//
//  ViewController.swift
//  TestProject
//
//  Created by user on 27.06.2023.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    var viewModel: MainViewModelProtocol!
    private var cancellable = Set<AnyCancellable>()
    //обновление таблицы
    var tableReload: Bool = false {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - tableView
    private lazy var tableView: UITableView = {
        var table = UITableView(frame: .zero, style: .insetGrouped)
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.backgroundColor = .white
        table.showsVerticalScrollIndicator = false
        
        table.register(TableCell.self,
                       forCellReuseIdentifier: TableCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchCategories()
        updateTableState()
        createConstraintsForTable()
        setNavigationBarMain()
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
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.categories?.сategories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier) as? TableCell {
            let cat = self.viewModel.categories?.сategories[indexPath.row]
            
            cell.selectionStyle = .none
            cell.configurate(name: cat?.name ?? "", imageData: self.viewModel.imageArray[indexPath.row])
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categorySelect = self.viewModel.categories?.сategories[indexPath.row].name ?? ""
        self.viewModel.coordinator.showDetailModule(categorySelect: categorySelect)
    }
}


extension UIViewController {
    func setNavigationBarMain() {
        let viewTitle = UIView(frame: .zero)
        viewTitle.frame = CGRect(x: .zero,
                                 y: .zero,
                                 width: view.frame.width,
                                 height: 44)
        viewTitle.clipsToBounds = true
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, YYYY"
        formatter.locale = Locale(identifier: "ru_RU")
        let dateString = formatter.string(from: currentDate).capitalized
        
        let imageView = UIImageView(image: UIImage(named: "location"))
        imageView.frame = CGRect(x: .zero,
                                 y: 5,
                                 width: 30,
                                 height: 20)
        imageView.contentMode = .scaleAspectFit
        
        let cityLabel = UILabel(frame: CGRect(x: 30,
                                              y: 1,
                                              width: 200,
                                              height: 20))
        cityLabel.text = "Санкт-Петербург"
        cityLabel.textColor = .black
        cityLabel.font = .boldSystemFont(ofSize: 18)
        
        let dateLabel = UILabel(frame: CGRect(x: 30,
                                              y: 20,
                                              width: 150,
                                              height: 20))
        dateLabel.text = dateString
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .gray
        
        let profileImageView = UIImageView(frame: CGRect(x:
                                                            view.frame.width - view.frame.width/5,
                                                         y: -2,
                                                         width: 44,
                                                         height: 44))
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

