//
//  DownloadUtility.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import Foundation
import UIKit

public enum ShadowPosition {
    case Top
    case Bottom
    case Left
    case Right
    case TopLeft
    case BottomRight
    case All
}

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
private let GRADIENT_LAYER_NAME: String = "gradient"
extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func addDropShadow(shadowRadius: CGFloat? = nil) {
        
        self.layer.masksToBounds = false
        
        // shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.2)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = shadowRadius ?? self.layer.cornerRadius
        
        self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: self.layer.cornerRadius == 0 ? 4.0 : self.layer.cornerRadius).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func addDefaultShadow(to layer: CALayer? = nil, shadowOpacity: Float = 0.2, shadowRadius: CGFloat = 2.0, pos: ShadowPosition = .All, shadowIntense: CGFloat = 1, shadowColor: CGColor = UIColor.black.cgColor) {
        
        let shadowLayer = layer ?? self.layer
        shadowLayer.masksToBounds = false
        
        // shadow
        shadowLayer.shadowColor = shadowColor
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowRadius
        
        switch pos {
        case .Left:
            shadowLayer.shadowOffset = CGSize(width: shadowIntense * -1, height: 0)
        case .Right:
            shadowLayer.shadowOffset = CGSize(width: shadowIntense, height: 0)
        case .Top:
            shadowLayer.shadowOffset = CGSize(width: 0, height: shadowIntense * -1)
        case .Bottom:
            shadowLayer.shadowOffset = CGSize(width: 0, height: shadowIntense)
        case .TopLeft:
            shadowLayer.shadowOffset = CGSize(width: shadowIntense * -1, height: shadowIntense * -1)
        case .BottomRight:
            shadowLayer.shadowOffset = CGSize(width: shadowIntense, height: shadowIntense)
        case .All:
            shadowLayer.shadowOffset = CGSize.zero
        }
        //shadowLayer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: 4.0).cgPath
        
        shadowLayer.shouldRasterize = true
        shadowLayer.rasterizationScale = UIScreen.main.scale
    }
    
    func addDefaultShadow(withPath: Bool = true, opacity: Float = 0.2, offset: CGSize = CGSize(width: 0, height: 1)) {
        
        self.layer.masksToBounds = false
        
        // shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = 2.0
        if withPath {
            self.layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: self.layer.cornerRadius == 0 ? 4.0 : self.layer.cornerRadius).cgPath
        }
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func removeGradientLayer() {
        let allLayers = self.layer.sublayers ?? []
        for layer in allLayers where layer.name == GRADIENT_LAYER_NAME {
            layer.removeFromSuperlayer()
        }
    }

    func addGradientColorWithCornerRadius(withColors colors: [UIColor], withType gradientType: GradientType, cornerRadius: CGFloat = .zero) {
        let gradient = CAGradientLayer()
        gradient.name = GRADIENT_LAYER_NAME
        gradient.frame = self.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.cornerRadius = cornerRadius
        removeGradientLayer()

        switch gradientType {
        case .linear(let startPoint, let endPoint):
            gradient.startPoint = startPoint
            gradient.endPoint = endPoint
            self.layer.insertSublayer(gradient, at: 0)
        case .radial(let center, let radius):
            let radialGradientLayer = CALayer()
            radialGradientLayer.frame = self.bounds
            radialGradientLayer.cornerRadius = self.layer.cornerRadius

            let maskLayer = CAShapeLayer()
            let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius)
            maskLayer.path = path.cgPath
            radialGradientLayer.mask = maskLayer

            gradient.frame = CGRect(origin: CGPoint(x: center.x - radius, y: center.y - radius), size: CGSize(width: radius * 2, height: radius * 2))
            radialGradientLayer.addSublayer(gradient)

            self.layer.insertSublayer(radialGradientLayer, at: 0)
        }
    }

    enum GradientType {
        case linear(startPoint: CGPoint, endPoint: CGPoint)
        case radial(center: CGPoint, radius: CGFloat)
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

extension UIImage {
    public func resizeImage(newWidth: CGFloat) -> UIImage?{
        let scale = newWidth / self.size.width
         let newHeight = self.size.height * scale
         UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
         self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
         let newImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
        return newImage
     }
}
