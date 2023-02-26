//
//  APICaller.swift
//  PixabayApp
//
//  Created by Almagul Musabekova on 22.02.2023.
//

import Foundation
import Alamofire

protocol APICallerDelegate {
    func didUpdateImageModelList(with modelList: [ImageModel])
    func  didUpdateVideoUrlList(with urlList: [String])
    func didFailWithError(_ error: Error)
}
struct APICaller {
    
    static var shared = APICaller()
    var delegate: APICallerDelegate?
    
    func fetchRequest(with query: String = "", mediaType: MediaType = .image)  {
        switch  mediaType  {
        case .image:
            let urlString = "\(Constants.URLs.baseImage)?key=\(Constants.API.key)&q=\(query)&image_type=photo"
//            guard let url = URL(string: urlString) else { return }
            AF.request(urlString).response  {  response in
                switch response.result {
                case .success(let data):
                    if let modelList = parseImageJSON(data!) {
                        delegate?.didUpdateImageModelList(with: modelList)
                    }
                case .failure(let error):
                    delegate?.didFailWithError(error)
                }
            }
        case .video:
            let urlString = "\(Constants.URLs.baseVideo)?key=\(Constants.API.key)&q=\(query)"
//            guard let url = URL(string: urlString) else { return }
            AF.request(urlString).response { response in
                switch response.result {
                case .success(let data):
                    if let urlList = parseVideoJSON(data!) {
                        delegate?.didUpdateVideoUrlList(with: urlList)
                    }
                case .failure(let error):
                    delegate?.didFailWithError(error)
                }
                
            }
        }
    }
        
        func parseImageJSON(_ data: Data) -> [ImageModel]? {
            var modelList: [ImageModel] = []
            do {
                let decodeData = try JSONDecoder().decode(ImageData.self, from: data)
                for imageData in decodeData.hits {
                    let imageModel = ImageModel(previewURL: imageData.previewURL, largeURL: imageData.largeURL)
                    modelList.append(imageModel)
                }
            } catch {
                delegate?.didFailWithError(error)
            }
            return modelList
        }
        
        func parseVideoJSON(_ data: Data) -> [String]? {
            var urlList: [String] = []
            do {
                let decodedData = try JSONDecoder().decode(VideoData.self, from: data)
                for videoData in decodedData.hits  {
                    urlList.append(videoData.videos.medium.url)
                }
            } catch {
                delegate?.didFailWithError(error)
            }
            return urlList
        }
    }

