//
//  ExploreVoucherCVC.swift
//  CreditManager
//
//  Created by Ritik Sharma on 17/08/23.
//

import UIKit

class ExploreVoucherCVC: UICollectionViewCell {
    public static let reuseIdentifier: String = "ExploreVoucherCVC"
    
    @IBOutlet weak var bottomTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        
        self.bgView.layer.borderWidth = 0.5
        self.bgView.layer.borderColor = UIColor(red: 0.329, green: 0.725, blue: 0.682, alpha: 1).cgColor
        self.bgView.backgroundColor = UIColor(red: 0.671, green: 0.945, blue: 0.914, alpha: 1)
        self.bgView.layer.cornerRadius = 12
        self.mainView.layer.borderWidth = 0.5
        self.mainView.layer.borderColor = UIColor(red: 0.329, green: 0.725, blue: 0.682, alpha: 1).cgColor
        self.mainView.backgroundColor = UIColor(red: 0.941, green: 0.988, blue: 0.984, alpha: 1)
        self.mainView.layer.cornerRadius = 12
    }
    func configure(with model: ExploreVoucherCVCModel?) {
        
        if let urlStr = model?.img, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.imgView.image = image
            })
        }
        self.bottomTitle.text = model?.title
    }
}
