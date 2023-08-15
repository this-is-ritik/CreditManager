//
//  BankDueCardTVC.swift
//  CreditManager
//
//  Created by Ritik Sharma on 15/08/23.
//

import UIKit

class BankDueCardTVC: UITableViewCell {

    @IBOutlet weak var bankImg: UIImageView!
    @IBOutlet weak var cardTypeLbl: UILabel!
    @IBOutlet weak var bankNameLbl: UILabel!
    @IBOutlet weak var dueAmountLbl: UILabel!
    @IBOutlet weak var dueDateLbl: UILabel!
    
    static let reuseIdentifier: String = "BankDueCardTVC"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bankNameLbl.textColor = UIColor(hex: "#131414")
        self.cardTypeLbl.textColor = UIColor(hex: "#858989")
        self.bankNameLbl.font = .systemFont(ofSize: 12, weight: .medium)
        self.cardTypeLbl.font = .systemFont(ofSize: 10, weight: .medium)
        self.dueAmountLbl.font = .systemFont(ofSize: 14, weight: .semibold)
        self.dueDateLbl.font = .systemFont(ofSize: 10, weight: .medium)
    }

    func configure(with model: BankDueCardModel?) {
        if let urlstr = model?.img, let url = URL(string: urlstr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.bankImg.image = image
            })
        }
        self.cardTypeLbl.text = model?.cardType
        self.bankNameLbl.text = model?.bankName
        if let amount = model?.amount {
            self.dueAmountLbl.isHidden = false
            self.dueAmountLbl.text = amount
        } else {
            self.dueAmountLbl.isHidden = true
        }
        self.dueDateLbl.text = model?.pendingDaysStatus
        self.dueDateLbl.textColor = UIColor(hex: model?.textColor)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.bankImg.image = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
