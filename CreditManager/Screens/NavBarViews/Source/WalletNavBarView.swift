//
//  WalletNavBarView.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import UIKit

class WalletNavBarView: UIView {

    
    @IBOutlet private weak var btn: UIButton!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: NavBarButton?) {
        self.btn.setTitle(model?.title, for: .normal)
        if let urlStr = model?.img, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.btn.setImage(image?.resizeImage(newWidth: 16), for: .normal)
                
            })
        }
        self.layer.borderColor = UIColor(hex: model?.borderColor).cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = model?.cornerRadius ?? .zero
    }
}
