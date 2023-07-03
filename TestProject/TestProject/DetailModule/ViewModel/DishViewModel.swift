//
//  DishViewModel.swift
//  TestProject
//
//  Created by user on 28.06.2023.
//

import Foundation
import Combine

protocol DishViewModelProtocol: AnyObject {
    var dishArray: DishArray? {get set}
    var imageArray: [Int : Data] {get set}
    var coordinator: MainCoordinatorProtocol! {get}
    var updateTableState: PassthroughSubject<Bool, Never> {get set}
    var sortDescriptor: Teg {get set}
    var titleArray: [String] {get}
    func fetchDish()
    func getDishSorted() -> DishArray
    func appendDish(dish: Dish, image: Data, key: String)
}

class DishViewModel: DishViewModelProtocol {
    var dishArray: DishArray?
    var imageArray: [Int : Data] = [:]
    var coordinator: MainCoordinatorProtocol!
    var updateTableState = PassthroughSubject<Bool, Never>()
    var sortDescriptor: Teg = .всеМеню { didSet {self.updateTableState.send(true)}}
    let titleArray = ["Все меню", "Салаты", "С рисом", "С рыбой", "Роллы"]
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - fetchDish
    func fetchDish() {
        guard let url = URL(string: "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b") else {return}
        let request = URLRequest(url: url)
        
        //издатель
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: DishArray.self, decoder: JSONDecoder())
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
            self.dishArray = result
            getImage()
        }.store(in: &cancellable)
    }
    
    //MARK: - getImage
    private func getImage() {
        guard let dishArray = dishArray?.dishes else {return}
        
        for item in dishArray {
            guard let url = URL(string: item.imageURL) else {return}
            
            let publisher = URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
            
            publisher.sink { completion in
                switch completion {
                case .finished:
                    print("image \(item.id) was winished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [unowned self] result in
                self.imageArray[item.id] = result
                if self.imageArray.count == self.dishArray?.dishes.count {
                    updateTableState.send(true)
                }
            }.store(in: &cancellable)
        }
    }
    
    //MARK: - getDishSorted
    func getDishSorted() -> DishArray {
        var dishSort: DishArray = .init(dishes: [])
        
        if let dishArray = dishArray?.dishes {
            for item in dishArray {
                for j in item.tegs {
                    if j == sortDescriptor {
                        dishSort.dishes.append(item)
                    }
                }
            }
        }
        return dishSort
    }
    
    //MARK: - appendDish
    func appendDish(dish: Dish, image: Data, key: String) {
        let dishModelForSave = DishModelForSave(name: dish.name, count: 1, price: dish.price, weight: dish.price, image: image)
        if var arrayLoad = UserDefaults.standard.load(arrayForKey: key) as [DishModelForSave]? {
            if arrayLoad.isEmpty {
                UserDefaults.standard.save(array: [dishModelForSave], forKey: key)
            } else {
                if arrayLoad.contains(where: {$0.name == dishModelForSave.name}) {
                    let index = arrayLoad.firstIndex(where: {$0.name == dishModelForSave.name}) ?? 0
                    arrayLoad[index].count += 1
                } else {
                    arrayLoad.append(dishModelForSave)
                }
                UserDefaults.standard.save(array: arrayLoad, forKey: key)
            }
        } else {
            UserDefaults.standard.save(array: [dishModelForSave], forKey: key)
        }
    }
    
}
