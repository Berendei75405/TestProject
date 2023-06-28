//
//  MainViewModel.swift
//  TestProject
//
//  Created by user on 28.06.2023.
//

import Foundation
import Combine

protocol MainViewModelProtocol {
    var categories: Categories? {get set}
    var imageArray: [Data] {get set}
    var coordinator: MainCoordinatorProtocol! {get}
    var updateTableState: PassthroughSubject<TableViewState, Never> {get set}
    func fetchCategories()
    func getImage()
}

class MainViewModel: MainViewModelProtocol {
    var vc: MainViewController!
    var categories: Categories?
    var imageArray: [Data] = []
    var coordinator: MainCoordinatorProtocol!
    var updateTableState = PassthroughSubject<TableViewState, Never>()
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - init
    init() {
        updateTableState.send(.initial)
    }
    
    //MARK: - fetchCategories
    func fetchCategories() {
        guard let url = URL(string: "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54") else {return}
        let request = URLRequest(url: url)
        
        //издатель
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Categories.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        publisher.sink { completion in
            switch completion {
            case .finished:
                print("Fetch categories pulisher was finished!")
            case .failure(let error):
                print(error)
            }
        } receiveValue: { [self] result in
            self.categories = result
            getImage()
        }.store(in: &cancellable)
    }
    
    //MARK: - getImage
    func getImage() {
        guard let categories = categories?.сategories else {return}
        
        for item in categories {
            guard let url = URL(string: item.imageURL) else {return}
            let request = URLRequest(url: url)
            
            //издатель
            let publisher = URLSession.shared.dataTaskPublisher(for: request)
                .map { $0.data }
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
            
            publisher.sink { [self] completion in
                switch completion {
                case .finished:
                    print("Image publisher was finished")
                case .failure(let error):
                    print("Image publisher error \(error.localizedDescription)")
                    self.updateTableState.send(.failure)
                }
            } receiveValue: { [self] data in
                self.imageArray.append(data)
                if imageArray.count == categories.count {
                    updateTableState.send(.success)
                }
            }.store(in: &cancellable)
        }
    }
    
}
