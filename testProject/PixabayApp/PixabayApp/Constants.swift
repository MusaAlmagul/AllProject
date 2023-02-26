//
//  Constants.swift
//  PixabayApp
//
//  Created by Almagul Musabekova on 20.02.2023.
//

import Foundation
import UIKit

struct Constants {
    
    struct API {
        static let key = "33773687-916100c65ea505c1995aa54c7"
     }
    
    struct Identifiers {
        static let mediaCollectionViewCell = "MediaCollectionViewCell"
    }
    
    struct URLs {
        static let baseImage = "https://pixabay.com/api/"
        static let baseVideo = "https://pixabay.com/api/videos/"
    }
    
    struct Values {
        static let screenWidth = UIScreen.main.bounds.width
    }
    
    struct Colors {
        static let imageCell = UIColor(red: 237/255, green: 248/255, blue: 235/255, alpha: 1)
        static let videoCell = UIColor(red: 30/255, green: 107/255, blue: 223/255, alpha: 0.2)
    }
}

enum MediaType: String {
    case image = "Image"
    case video = "Video"
}
