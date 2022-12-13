//
//  Pet.swift
//  Pets Info
//
//  Created by Yurii on 13.12.2022.
//

import Foundation

struct Pet: Codable {
    let title: String
    let description: String
    let image: URL
    let order: Int
    let status: Status
    let content: [Info]?
}
