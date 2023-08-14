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

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}

extension UIColor {
    convenience init(hex: String?, alpha: CGFloat = 1.0) {
        guard var hex else { self.init(red: 0, green: 0, blue: 0, alpha: alpha);return}
        hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a: CGFloat
        let r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (alpha, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (alpha, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (CGFloat(int >> 24) / 255, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (alpha, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: a)
    }
}
