//
//  ImageStorageManager.swift
//  CreditManager
//
//  Created by Ritik Sharma on 15/08/23.
//

import Foundation
import UIKit

class ImageDownloader {
    static let shared = ImageDownloader()
    private let imageCache = NSCache<NSString, UIImage>()
    private init() {}
    func downloadImage(withURL url: URL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            // Return cached image if available in NSCache
            completion(cachedImage)
        } else if let imgData = UserDefaults.standard.data(forKey: url.absoluteString), let img = UIImage(data: imgData) {
            // Return cached image if available in UserDefaults
            imageCache.setObject(img, forKey: url.absoluteString as NSString)
            completion(img)
        } else {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, let downloadedImage = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                // Cache the downloaded image in both NSCache and UserDefaults
                self.imageCache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                UserDefaults.standard.set(data, forKey: url.absoluteString)
                DispatchQueue.main.async {
                    completion(downloadedImage)
                }
            }
            task.resume()
        }
    }
}
