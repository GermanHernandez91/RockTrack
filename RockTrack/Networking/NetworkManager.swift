//
//  NetworkManager.swift
//  RockTrack
//
//  Created by German Hernandez on 28/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

typealias NetworkResult = (Result<[Track], RTError>) -> Void

class NetworkManager {
    
    // NetworkManage is a singleton so it guarantees that only one instance of a class is instantiated.
    static let shared = NetworkManager()
    
    private init() {}
    private let baseURL: String = "https://itunes.apple.com/search?term=rock&media=music"
    
    // Cache object for images so it will load an image once and then it will use the cache to save memory and resources.
    let cache = NSCache<NSString, UIImage>()
    
    func getTracks(completed: @escaping NetworkResult) {
        
        guard let url = URL(string: baseURL) else {
            completed(.failure(.genericError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let tracks = try decoder.decode(Tracks.self, from: data)
                completed(.success(tracks.results))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    // This method will take a track image and it will return the image either from the cache or the network.
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        // If the image is cached, it will return it.
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        // If the image is not cached, it will download the image from the network.
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        
        task.resume()
    }
}
