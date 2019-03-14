//
//  ImageManager.swift
//  ListImage
//
//  Created by Nanang Rafsanjani on 14/03/19.
//  Copyright © 2019 Nanang Rafsanjani. All rights reserved.
//

import UIKit

class ImageDownloader {
    static func downloadImage(url: URL, completion: ((UIImage?, Error?) -> Void)?) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion?(nil, error)
                    return
                }
                completion?(UIImage(data: data), nil)
            }
        }
        task.resume()
    }
}

class ImageMemoryCache {
    var data = [String: UIImage]()
    static let shared = ImageMemoryCache()
}

extension UIImageView {
    func setImageWithURL(_ url: URL) {
        self.image = nil
        
        if let image = ImageMemoryCache.shared.data[url.absoluteString] {
            self.image = image
        } else {
            ImageDownloader.downloadImage(url: url) { [weak self] (image, error) in
                guard let image = image else {
                    return
                }
                ImageMemoryCache.shared.data[url.absoluteString] = image                
                self?.setImageWithURL(url)
            }
        }
    }
}
