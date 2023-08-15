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
    
    static let reuseIdentifier: String = "LinkPersuasionCardTVC"
    private var model: LinkPersuasionModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = .clear
        self.headerLbl.textColor = .black
        self.headerLbl.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.subheaderLbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.subheaderLbl.textColor = UIColor(hex: "#131414")
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor(hex: "#E6EAE9").cgColor
        self.contentView.layer.cornerRadius = 16
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
        self.contentView.addGradientColorWithCornerRadius(withColors: colors, withType: .radial(center: CGPoint(x: self.contentView.frame.midX, y: self.contentView.frame.midY), radius: self.contentView.frame.width), cornerRadius: 16)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
