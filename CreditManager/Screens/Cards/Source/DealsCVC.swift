//
//  DealsCVC.swift
//  CreditManager
//
//  Created by Ritik Sharma on 18/08/23.
//

import UIKit

class DealsCVC: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var imgBgView: UIView!
    @IBOutlet weak var upperImgView: UIImageView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    
    
    @IBOutlet weak var subHeaderView: UIView!
    
    @IBOutlet weak var subheaderCta: UIButton!
    
    
    @IBOutlet weak var rightArrowImgView: UIImageView!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var bottomImgView: UIImageView!
    
    
    public static let reuseIdentifier: String = "DealsCVC"
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.bgView.layer.borderWidth = 0.5
        self.bgView.layer.borderColor = UIColor(red: 0.329, green: 0.725, blue: 0.682, alpha: 1).cgColor
        self.bgView.backgroundColor = UIColor(red: 0.671, green: 0.945, blue: 0.914, alpha: 1)
        self.bgView.layer.cornerRadius = 12
        self.mainView.layer.borderWidth = 0.5
        self.mainView.layer.borderColor = UIColor(red: 0.329, green: 0.725, blue: 0.682, alpha: 1).cgColor
        self.mainView.backgroundColor = UIColor(red: 0.941, green: 0.988, blue: 0.984, alpha: 1)
        self.mainView.layer.cornerRadius = 12
        self.headerLbl.textColor = .white
        self.subheaderCta.tintColor = .white
        self.textLbl.textColor = .white
        self.rightArrowImgView.tintColor = .white
        
        self.headerLbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.subheaderCta.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        self.textLbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.imgBgView.backgroundColor = .white
        self.bottomView.layer.cornerRadius = 12
        self.imgBgView.layer.cornerRadius = 12
    }
    func configure(with model: FeaturedCVCModel?) {
        self.upperImgView.backgroundColor = .white
        if let urlStr = model?.merchLogo, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.upperImgView.image = image
            })
        }
        if let urlStr = model?.bottomImg, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.bottomImgView.image = image
            })
        }
        
        if let urlStr = model?.chipsImg, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.subheaderCta.setImage(image?.resizeImage(newWidth: 16), for: .normal)
            })
        }
        
        self.headerLbl.text = model?.header
        self.subheaderCta.setTitle(model?.persuasionText, for: .normal)
        
        self.mainView.backgroundColor = UIColor(hex: model?.bgColor)
        self.bottomView.backgroundColor = UIColor(hex: model?.bgColor)
        
        self.textLbl.text = model?.text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let rect = self.imgBgView.bounds
        let y = rect.size.height - 10
        let curveTo = rect.size.height + 10

        let myBez = UIBezierPath()
        myBez.move(to: CGPoint(x: 0.0, y: y))
        myBez.addQuadCurve(to: CGPoint(x: rect.size.width, y: y), controlPoint: CGPoint(x: rect.size.width / 2.0, y: curveTo))
        myBez.addLine(to: CGPoint(x: rect.size.width, y: 0.0))
        myBez.addLine(to: CGPoint(x: 0.0, y: 0.0))
        myBez.close()

        let maskForPath = CAShapeLayer()
        maskForPath.path = myBez.cgPath
        self.imgBgView.layer.mask = maskForPath
    }
}
