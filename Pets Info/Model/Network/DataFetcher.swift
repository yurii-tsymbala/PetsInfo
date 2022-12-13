//
//  DataFetcher.swift
//  Pets Info
//
//  Created by Yurii on 13.12.2022.
//

import Foundation

class DataFetcher {
    
    // MARK: refactor with async and handling result with error
    
    func fetchData() {
        
        var result: [Pet]?
        let filename = "petsData"
        let data: Data
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else {
                fatalError("Couldn't find \(filename) in main bundle.")
            }
        
            do {
                data = try Data(contentsOf: file)
            } catch {
                fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
            }
        
            do {
                result = try JSONDecoder().decode([Pet].self, from: data)
                if let result = result {
                    print(result)
                }
            } catch {
                fatalError("Couldn't parse \(filename) as \([Pet].self):\n\(error)")
            }
    }
}


