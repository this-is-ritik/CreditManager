//
//  DownloadUtility.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import Foundation
import UIKit

extension UIImageView {
    public func download(with url: String?, closure: @escaping (UIImage?) -> Void) {
        guard let url, let imgUrl = URL(string: url) else { return }
        let urlReq = URLRequest(url: imgUrl)
        URLSession.shared.dataTask(with: urlReq) { (data, _, error) in
            if let error {
                print("error in downloading \(url): \(error)")
            }
            var img: UIImage? = nil
            if let data {
                img = UIImage(data: data)
            }
            closure(img)
        }.resume()
    }
}
