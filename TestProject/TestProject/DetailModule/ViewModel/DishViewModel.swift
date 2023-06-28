//
//  DishViewModel.swift
//  TestProject
//
//  Created by user on 28.06.2023.
//

import Foundation

protocol DishViewModelProtocol {
    var dishArray: [Dish] {get set}
    var coordinator: MainCoordinatorProtocol! {get}
}

class DishViewModel: DishViewModelProtocol {
    var vc: DishViewController!
    var dishArray: [Dish] = []
    var coordinator: MainCoordinatorProtocol!
    
}
