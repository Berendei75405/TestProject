//
//  BasketViewModel.swift
//  TestProject
//
//  Created by user on 02.07.2023.
//
import UIKit
import Combine

protocol BasketViewModelProtocol {
    var coordinator: MainCoordinatorProtocol! {get}
    var reloadView: PassthroughSubject<Bool, Never> {get set}
    func getModel() -> [DishModelForSave]
    func appendModel(index: Int)
    func removeModel(index: Int)
    func returnTotalPrice() -> String
}

class BasketViewModel: BasketViewModelProtocol {
    var coordinator: MainCoordinatorProtocol!
    //обновляет кнопку или таблицу
    var reloadView = PassthroughSubject<Bool, Never>()
    
    //MARK: - getModel
    func getModel() -> [DishModelForSave] {
        if let arrayLoad = UserDefaults.standard.load(arrayForKey: "dish") as [DishModelForSave]? {
            
            return arrayLoad
        }
        return []
    }
    
    //MARK: - appendModel
    func appendModel(index: Int) {
        guard var arrayLoad = UserDefaults.standard.load(arrayForKey: "dish") as [DishModelForSave]? else {return}
        arrayLoad[index].count += 1
        UserDefaults.standard.save(array: arrayLoad, forKey: "dish")
        reloadView.send(true)
    }
    
    //MARK: - removeModel
    func removeModel(index: Int) {
        guard var arrayLoad = UserDefaults.standard.load(arrayForKey: "dish") as [DishModelForSave]? else {return}
        if arrayLoad[index].count > 1 {
            arrayLoad[index].count -= 1
        } else {
            arrayLoad.remove(at: index)
        }
        UserDefaults.standard.save(array: arrayLoad, forKey: "dish")
        reloadView.send(false)
    }
    
    //MARK: - returnTotalPrice
    func returnTotalPrice() -> String {
        let array = getModel()
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        var totalPrice = 0
        
        for i in array {
            totalPrice += i.count * i.price
        }
        
        return formatter.string(from: NSNumber(value: totalPrice))!
    }
}
