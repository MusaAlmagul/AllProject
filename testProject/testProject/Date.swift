//
//  Date.swift
//  testProject
//
//  Created by Almagul Musabekova on 28.01.2023.
//

import Foundation

struct DateBase {
    
    static let sightList: [Sight] = [Sight(name: "Nur", tourPrice: 1200, imageName: "nur"),
                                     Sight(name: "Charyn", tourPrice: 2500, imageName: "charyn"),
                                     Sight(name: "Kazakhstan", tourPrice: 1000, imageName: "kazakhstan"),
                                     Sight(name: "Turkistan", tourPrice: 800, imageName: "turkistan"),
                                     Sight(name: "Mausoleum", tourPrice: 3000, imageName: "mausoleum"),
                                     Sight(name: "Mangystau", tourPrice: 2800, imageName: "mangystau"),]
}

struct Sight {
   
    var name: String
    var tourPrice: Float
    var imageName: String
    
    
}
