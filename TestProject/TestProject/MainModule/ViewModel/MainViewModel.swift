//
//  MainViewModel.swift
//  TestProject
//
//  Created by user on 28.06.2023.
//

import Foundation
import Combine

protocol MainViewModelProtocol: AnyObject {
    var categories: Categories? {get set}
    var imageArray: [Data] {get set}
    var coordinator: MainCoordinatorProtocol! {get}
    var updateTableState: PassthroughSubject<Bool, Never> {get set}
    func fetchCategories()
    func getImage()
}

class MainViewModel: MainViewModelProtocol {
    var categories: Categories?
    var imageArray: [Data] = []
    var coordinator: MainCoordinatorProtocol!
    private let networkManager = NetworkManager.shared
    var updateTableState = PassthroughSubject<Bool, Never>()
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - init
    init() {
        updateTableState.send(false)
    }
    
    //MARK: - fetchCategories
    func fetchCategories() {
        networkManager.getCategory { [unowned self] result in
            switch result {
            case .success(let category):
                self.categories = category
                getImage()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - getImage
    func getImage() {
        guard let categories = categories?.сategories else {return}
        var arrayUrlString: [String] = []
        
        for item in categories {
            arrayUrlString.append(item.imageURL)
        }
        networkManager.getImageArray(url: arrayUrlString) { [unowned self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                if data.contains(where: {$0 != nil}) {
                    self.imageArray = data.map {$0!}
                    updateTableState.send(true)
                }
            }
        }
    }
}
