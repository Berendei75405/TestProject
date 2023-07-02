//
//  BasketViewModel.swift
//  TestProject
//
//  Created by user on 02.07.2023.
//

import UIKit

protocol BasketViewModelProtocol {
    var coordinator: MainCoordinatorProtocol! {get}
}

class BasketViewModel: BasketViewModelProtocol {
    var coordinator: MainCoordinatorProtocol!
    
}
