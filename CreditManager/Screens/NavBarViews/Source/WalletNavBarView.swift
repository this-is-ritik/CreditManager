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
        self.btn.setImage(UIImage(named: model?.img ?? "Chips", in: .main, with: .none), for: .normal)
        self.layer.borderColor = UIColor(hex: model?.borderColor).cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = model?.cornerRadius ?? .zero
    }
}
