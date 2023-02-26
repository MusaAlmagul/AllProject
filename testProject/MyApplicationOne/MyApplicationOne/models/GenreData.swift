//
//  GenreData.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 18.02.2023.
//

import Foundation

struct GenreData: Decodable {
    let genres: [Genre]
   
    struct Genre: Decodable {
        let id: Int
        let name: String
    }
}
