//
//  MovieData.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 10.02.2023.
//

import Foundation

struct MovieData: Decodable {
    let results: [Results]
    
    struct Results: Decodable {
        let backdrop_path: String?
        let id: Int
        let title: String
        let poster_path: String
        let genre_ids: [Int]
        
    }
}

//struct MovieData {
//    let pageProps: PageProps
//}
//struct PageProps {
//    let cinema: [Cinema]
//}
//struct Cinema {
//    
//}
