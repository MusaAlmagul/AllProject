//
//  APIMovie.swift
//  MyApplicationOne
//
//  Created by Almagul Musabekova on 06.02.2023.
//

import Foundation

protocol APICallerDelegate {
    func didUpdateAllMovieList(with movieList: [MovieModel])
    func didUpdateGenreList(with genreList: [Int:String])
    func didUpdateDetailedModel(with model: DetailedMovieModel)
    func didFaiWithError(_ error: Error )
}

struct ApiMovie {
    
    var delegate: APICallerDelegate?
    private var genreList: [Int:String] = [:]
    
    func fetchRequest(_ type: RequestType) {
        switch type {
        case .movie:
            for urlString in Constants.Values.urlList {
                // let urlString = Constants.URLs.trending для каждого урл создавалась
                //https://api.themoviedb.org/3/movie/550?api_key=c8c878f3cd2a96dc155b79483f44b938
                
                guard let url = URL(string: urlString) else { fatalError("Incorrect link!") }
                let task = URLSession.shared.dataTask(with: url) { data, _, error in
                    if let data, error == nil {
                        if let movieList = parseMovieJSON(data) {
                            
                            print( movieList[0].title)
                            delegate?.didUpdateAllMovieList(with: movieList)
                        } else {
                            delegate?.didFaiWithError(error!)
                        }
                        
                    } else {
                        delegate?.didFaiWithError(error!)
                    }
                }
                task.resume()
            }
        case.genre:
            let urlString = "\(Constants.Links.api)genre/movie/list?api_key=\(Constants.Keys.api)"
            guard let url = URL(string: urlString) else { fatalError("Incorrect Link!") }
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let data, error == nil {
                    if let genreList = parseGenreJson(data) {
                        delegate?.didUpdateGenreList(with: genreList)
                    }
                } else {
                    delegate?.didFaiWithError(error!)
                }
            }
            task.resume()
        }
    }
    
    
    func fetchRequest(with id: Int) {
        let urlString = "\(Constants.Links.api)movie\(id)?api_key=\(Constants.Keys.api)"
        guard let url = URL(string: urlString) else { fatalError("Incorrect link with movie id!") }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data, error == nil {
                if let model = parseDetailedMovieJSON(data) {
                    delegate?.didUpdateDetailedModel(with: model)
                } else {
                    delegate?.didFaiWithError(error!)
                }
            } else {
                delegate?.didFaiWithError(error!)
            }
        }
        task.resume()
    }
    func fetchRequest() {
//        let urlString = "\(Constants.Links.api)genre/movie/list?api_key=\(Constants.Keys.api)"
//        guard let url = URL(string: urlString) else { fatalError("Incorrect Link!") }
//        let task = URLSession().dataTask(with: url) { data, _, error in
//            if let data, error == nil {
//                if let genreList = parseGenreJson(data) {
//                    self.genreList = genreList
//                }
//            } else {
//                delegate?.didFaiWithError(error!)
//            }
//        }
//        task.resume()
    }
    func parseMovieJSON(_ data: Data) -> [MovieModel]? {
        var movieList: [MovieModel] = []
        do {
            let decodedData = try JSONDecoder().decode(MovieData.self, from:  data)
            for model in decodedData.results {
                if let backDropPath = model.backdrop_path {
                    let movieModel = MovieModel(backdropPath: backDropPath, id: model.id, title: model.title, posterPath: model.poster_path, genreIds: model.genre_ids)
                    movieList.append(movieModel)
                }
            }
        } catch {
            print(error)
            return nil
        }
        return movieList
    }
    
    func parseGenreJson(_ data: Data) -> [Int: String]? {
        var genreList: [Int: String] = [:]
        do {
            let decodedData = try JSONDecoder().decode(GenreData.self, from: data)
            for model in decodedData.genres {
                genreList[model.id] = model.name
            }
        } catch {
            print(error)
           return nil
        }
        return genreList
    }
    func parseDetailedMovieJSON(_ data: Data) -> DetailedMovieModel? {
        do {
            let decodedData = try JSONDecoder().decode(DetailedMovieData.self, from: data)
            let model = DetailedMovieModel.self(posterPath: decodedData.poster_path, backdropPath: decodedData.backdrop_path, title: decodedData.title, tagline: decodedData.tagline, overview: decodedData.overview)
            return model
        } catch {
            print(error)
            return nil
        }
    }
}
extension APICallerDelegate {
    func didUpdateAllMovieList(with movieList: [MovieModel]) {
        print("Default implementation!")
    }
    func didUpdateGenreList(with genreList: [Int:String]) {
        print("Default implementation!")
    }
    func didUpdateDetailedModel(with model: DetailedMovieModel) {
        print("Default implementation!")
    }
    func didFaiWithError(_ error: Error) {
        print("Failer with error", error)
    }
}



//"c8c878f3cd2a96dc155b79483f44b938"
