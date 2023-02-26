//
//  ImageData.swift
//  PixabayApp
//
//  Created by Almagul Musabekova on 22.02.2023.
//

import Foundation

struct ImageData: Decodable {
    let hits: [ImageHit]
    
    struct ImageHit: Decodable {
        let previewURL: String
        let largeURL: String
        
    }
}
