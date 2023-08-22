//
//  LinkPersuasionCardTVC.swift
//  CreditManager
//
//  Created by Ritik Sharma on 15/08/23.
//

import UIKit

class LinkPersuasionCardTVC: UITableViewCell {

    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var linkCta: UIButton!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var subheaderLbl: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    static let reuseIdentifier: String = "LinkPersuasionCardTVC"
    private var model: LinkPersuasionModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = .white
        self.headerLbl.textColor = .black
        self.headerLbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.mainView.layer.masksToBounds = true
        self.subheaderLbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.subheaderLbl.textColor = UIColor(hex: "#131414")
        self.mainView.layer.borderWidth = 1
        self.mainView.layer.borderColor = UIColor(hex: "#E6EAE9").cgColor
        self.mainView.layer.cornerRadius = 16
    }

    func configure(with model: LinkPersuasionModel?) {
        if let urlStr = model?.cardData?.img, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.rightImageView.image = image
                
            })
        }
        self.model = model
        self.linkCta.setAttributedTitle(NSAttributedString(string: model?.cardData?.ctaText ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .medium)]), for: .normal)
        self.headerLbl.text = model?.cardData?.header
        self.subheaderLbl.text = model?.cardData?.subheader
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let colors: [UIColor] = model?.cardData?.bgColors?.compactMap { UIColor(hex: $0)} ?? []
        self.mainView.addGradientColorWithCornerRadius(withColors: colors, withType: .radial(center: .init(x: 0.5, y: 0.5), radius: self.mainView.bounds.width), cornerRadius: 16)
    }

}
