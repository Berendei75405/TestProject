//
//  NetworkManager.swift
//  TestProject
//
//  Created by user on 03.07.2023.
//

import Foundation

class NetworkManager {
    private var networkService = NetworkService.shared
    static let shared = NetworkManager()
    
    private init() {}

    //MARK: - getCategory
    func getCategory(completion: @escaping (Result<Categories, Error>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        networkService.makeRequest(request: request, completion: completion)
    }
    
    //MARK: - getDish
    func getDish(completion: @escaping (Result<DishArray, Error>) -> Void) {
        guard let url = URL(string: "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        networkService.makeRequest(request: request, completion: completion)
    }
    
    func getImageArray(url: [String],
                completion: @escaping (Result<[Data?], Error>) -> Void) {
        var requestArray: [URLRequest] = []
        for urlString in url {
            guard let url = URL(string: urlString) else {return}
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            requestArray.append(urlRequest)
        }
        networkService.makeRequestForDataArray(request: requestArray, completion: completion)
    }
    
}
