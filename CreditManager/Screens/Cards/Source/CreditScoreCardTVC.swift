//
//  CreditScoreCardTVC.swift
//  CreditManager
//
//  Created by Ritik Sharma on 15/08/23.
//

import UIKit

class CreditScoreCardTVC: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var creditScoreProvider: UIImageView!
    @IBOutlet weak var rightArrow: UIImageView!
    @IBOutlet weak var byLbl: UILabel!
    @IBOutlet weak var creditScoreLbl: UILabel!
    @IBOutlet weak var feedbackLbl: UILabel!
    
    @IBOutlet weak var maxScoreLbl: UILabel!
    static let reuseIdentifier: String = "CreditScoreCardTVC"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.creditScoreLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        self.maxScoreLbl.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        self.byLbl.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        self.feedbackLbl.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        
        self.creditScoreLbl.textColor = .black
        self.maxScoreLbl.textColor = UIColor(hex: "#CACFCF")
        self.byLbl.textColor = UIColor(hex: "#CACFCF")
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor(hex: "#E6EAE9").cgColor
        self.contentView.layer.cornerRadius = 16
        
    }

    func configure(with model: CreditScoreModel?) {
        if let urlStr = model?.img, let imgUrl = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: imgUrl, completion: { image in
                self.imgView.image = image
            })
        }
        if let urlStr = model?.providerImg, let imgUrl = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: imgUrl, completion: { image in
                self.creditScoreProvider.image = image
            })
        }
        self.rightArrow.tintColor = UIColor(hex: model?.arrowColor)
        self.byLbl.text = model?.providerText
        self.creditScoreLbl.text = model?.score
        self.feedbackLbl.text = model?.scoreStatus
        self.feedbackLbl.textColor = UIColor(hex: model?.scoreStatusColor)
        if let maxScore = model?.maxScore {
            self.maxScoreLbl.text = " / \(maxScore)"
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
