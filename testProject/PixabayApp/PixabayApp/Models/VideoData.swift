//
//  VideoData.swift
//  PixabayApp
//
//  Created by Almagul Musabekova on 25.02.2023.
//

import Foundation

struct VideoData: Decodable{
    let hits: [VideoData]
    
    struct VideoHit: Decodable {
        let videos: Video
        
        struct Video: Decodable {
            let medium: Medium
            
            struct Medium: Decodable {
                let url: String
            }
        }
    }
}
