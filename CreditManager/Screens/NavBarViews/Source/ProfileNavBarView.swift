//
//  ProfileNavBarView.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import UIKit

class ProfileNavBarView: UIView {

    @IBOutlet weak var imgView: UIImageView!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    
    func configureView(with model: NavBarButton?) {
        if let urlStr = model?.img, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                if let image {
                    self.imgView.image = image.resizeImage(newWidth: 32)
                }
                
            })
        }
        
    }
}
