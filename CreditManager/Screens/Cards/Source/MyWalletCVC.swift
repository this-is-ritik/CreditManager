//
//  MyWalletCVC.swift
//  CreditManager
//
//  Created by Ritik Sharma on 18/08/23.
//

import UIKit

class MyWalletCVC: UICollectionViewCell {
    public static let reuseIdentifier: String = "MyWalletCVC"
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var leftImgView: UIImageView!
    
    @IBOutlet weak var leftLbl: UILabel!
    
    @IBOutlet weak var rightImgView: UIImageView!
    
    @IBOutlet weak var rightLb: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.layer.cornerRadius = 16
        self.mainView.layer.borderColor = UIColor(hex: "#E6EAE9").cgColor
        self.headerLbl.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        self.leftLbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.leftLbl.textColor = UIColor(hex: "#202948")
        self.rightLb.textColor = UIColor(hex: "#ADB2B2")
        self.rightLb.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        self.mainView.layer.borderColor = UIColor(hex: "#ADB2B2").cgColor
        self.mainView.layer.borderWidth = 1
        
    }
    
    func configure(with model: MyWalletCVCModel?) {
        self.headerLbl.text = model?.header
        self.leftLbl.text = model?.title
        self.rightLb.text = model?.subTitle
        if let urlStr = model?.img, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.leftImgView.image = image?.resizeImage(newWidth: 20)
            })
        }
        if let urlStr = model?.rightImg, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.rightImgView.image = image?.resizeImage(newWidth: 12)
            })
        }
    }
}
