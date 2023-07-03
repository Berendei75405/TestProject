//
//  Extension UserDefaults.swift
//  TestProject
//
//  Created by user on 03.07.2023.
//

import Foundation

extension UserDefaults {
    //MARK: - save
    func save<T: Codable>(array: [T], forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(array) {
            self.set(encoded, forKey: key)
        }
    }
    
    //MARK: - load
    func load<T: Codable>(arrayForKey key: String) -> [T]? {
        guard let data = self.data(forKey: key) else { return nil }
        
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([T].self, from: data) {
            return decoded
        }
        return nil
    }
}
