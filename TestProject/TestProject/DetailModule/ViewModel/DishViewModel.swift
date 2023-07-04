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
    var imageArray: [Data] {get set}
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
    var imageArray: [Data] = []
    private var networkManager = NetworkManager.shared
    var coordinator: MainCoordinatorProtocol!
    var updateTableState = PassthroughSubject<Bool, Never>()
    var sortDescriptor: Teg = .всеМеню { didSet {self.updateTableState.send(true)}}
    let titleArray = ["Все меню", "Салаты", "С рисом", "С рыбой", "Роллы"]
    private var cancellable = Set<AnyCancellable>()
    
    //MARK: - fetchDish
    func fetchDish() {
        networkManager.getDish { [unowned self] result in
            switch result {
            case .success(let dish):
                self.dishArray = dish
                getImage()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - getImage
    private func getImage() {
        guard let dishArray = dishArray?.dishes else {return}
        var arrayUrlString: [String] = []
        
        for item in dishArray {
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
