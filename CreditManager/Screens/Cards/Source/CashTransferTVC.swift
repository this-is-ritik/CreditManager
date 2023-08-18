//
//  CashTransferTVC.swift
//  CreditManager
//
//  Created by Ritik Sharma on 18/08/23.
//

import UIKit

class CashTransferTVC: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var headerLbkl: UILabel!
    @IBOutlet weak var subheaderLbl: UILabel!
    @IBOutlet weak var arrowImgView: UIImageView!
    @IBOutlet weak var rightCta: UIButton!
    @IBOutlet weak var rightImgView: UIImageView!
    @IBOutlet weak var arrowView: UIView!
    
    public static let reuseIdentifier: String = "CashTransferTVC"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.arrowView.layer.cornerRadius = 4
        self.rightCta.tintColor = UIColor(hex: "#6E7170")
        self.rightCta.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        self.headerLbkl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.subheaderLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        self.bgView.layer.cornerRadius = 17
        self.mainView.layer.cornerRadius = 17
        self.bgView.backgroundColor = UIColor(hex: "#00C197")
        
    }
    

    func configure(with model: CashTransferTVCModel?) {
        self.headerLbkl.text = model?.header
        self.subheaderLbl.text = model?.subheader
        self.arrowImgView.tintColor = UIColor(hex: model?.arrowTintColor)
        self.rightCta.setTitle(model?.persuasionText, for: .normal)
        self.mainView.backgroundColor = UIColor(hex: model?.bgColor)
        if let urlStr = model?.chipsImg, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.rightCta.setImage(image?.resizeImage(newWidth: 14), for: .normal)
            })
        }
        if let urlStr = model?.img, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.rightImgView.image = image
            })
        }
    }
}
