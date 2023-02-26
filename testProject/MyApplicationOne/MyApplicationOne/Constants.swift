//
//  File.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 30.01.2023.
//

import Foundation
import UIKit

struct Constants {
    
    struct Keys {
        static let api = "c8c878f3cd2a96dc155b79483f44b938"
    }
    struct Idenrifiers {
        static let categoryCollectionViewCell = "CategoryCollectionViewCell"
        static let trendingCollectionViewCell = "TrendingCollectionViewCell"
        static let categoryTableViewCell = "CategoryTableViewCell"
        static let movieCollectionViewCell = "MovieCollectionViewCell"
    }
    /*
     https://api.themoviedb.org/3/trending/movie/day?api_key=c8c878f3cd2a96dc155b79483f44b938
     https://api.themoviedb.org/3/movie/now_playing?api_key=%22c8c878f3cd2a96dc155b79483f44b938%22&language=en-US&page=1
     https://api.themoviedb.org/3/movie/popular?api_key=c8c878f3cd2a96dc155b79483f44b938&language=en-US&page=1
     https://api.themoviedb.org/3/movie/top_rated?api_key=c8c878f3cd2a96dc155b79483f44b938&language=en-US&page=1
     https://api.themoviedb.org/3/movie/upcoming?api_key=c8c878f3cd2a96dc155b79483f44b938&language=en-US&page=1
     */
    struct Values {
        static let screenHeight = UIScreen.main.bounds.height
        static let urlList = [URLs.trending,URLs.nowPlaying, URLs.nowPopular,URLs.topRated, URLs.uncoming]
    }
    
    struct Colors {
       
    }
    struct Links {
        static let api = "https://apithemoviedb.org/3/"
        static let image = "https://image.tmdb.org/t/p/w500"
    }
    struct URLs{
        static let trending = "\(Links.api)trending/movie/day?api_key=\(Keys.api)"
        static let nowPlaying = "\(Links.api)movie/now_playing?api_key=\(Keys.api)"
        static let nowPopular = "\(Links.api)movie/popular?api_key=\(Keys.api)"
        static let topRated = "\(Links.api)movie/top_rated?api_key=\(Keys.api)"
        static let uncoming = "\(Links.api)movie/upcoming?api_key=\(Keys.api)"
        
    }
}

enum Category: String, CaseIterable {
    case nowPlaying = "🎬Now Playing"
    case nowPopular = "🎥Popular"
    case topRated = "📺Top Rated"
    case upcoming = "🍿Upcoming"
}
enum RequestType {
    case movie, genre
}
