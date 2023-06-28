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
    var coordinator: MainCoordinatorProtocol! {get}
    var updateTableState: PassthroughSubject<TableViewState, Never> {get set}
    func fetchCategories()
}

class MainViewModel: MainViewModelProtocol {
    var vc: MainViewController!
    var categories: Categories?
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
        
        publisher.sink { [self] completion in
            switch completion {
            case .finished:
                print("Fetch categories pulisher is finished!")
                
            case .failure(let error):
                print(error)
                self.updateTableState.send(.failure)
            }
        } receiveValue: { [self] result in
            self.categories = result
            print(self.categories!.сategories.count)
            self.updateTableState.send(.success)
        }.store(in: &cancellable)
    }
}
