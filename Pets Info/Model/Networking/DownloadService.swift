//
//  DataFetcher.swift
//  Pets Info
//
//  Created by Yurii on 13.12.2022.
//

import UIKit

enum DownloadServiceError: String {
    case firstError = "Json Decoding Error"
    case secondError = "Data Response Error"
    case thirdError  = "File Decoding Error"
}

typealias DownloadResponse = (Result<[Pet], DownloadServiceError>) -> Void

class DownloadService {
    
    func fetchDataFromFile(completion: @escaping DownloadResponse) {
        let result: [Pet]?
        let data: Data
        
        guard let file = Bundle.main.url(forResource: "petsData", withExtension: "json") else { completion(Result.failure(DownloadServiceError.thirdError)); return }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            completion(Result.failure(DownloadServiceError.secondError)); return }
        
        do {
            result = try JSONDecoder().decode([Pet].self, from: data)
            if let result = result {
                completion(Result.success(result)) }
        } catch {
            completion(Result.failure(DownloadServiceError.firstError)); return }
    }
    
    func downloadImage(imageURL: URL, completion: @escaping (Result<UIImage, DownloadServiceError>) -> Void) {
        let downloadPicTask = URLSession(configuration: .default).dataTask(with: imageURL) { (data,_,error) in
            guard error == nil, let imageData = data else {completion(Result.failure(.firstError)); return}
                guard let image = UIImage(data: imageData) else {completion(Result.failure(.secondError)); return}
                completion(Result.success(image))
        }
        downloadPicTask.resume()
    }
    
}



