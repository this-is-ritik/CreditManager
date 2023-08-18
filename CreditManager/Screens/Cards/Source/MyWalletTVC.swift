//
//  MyWalletTVC.swift
//  CreditManager
//
//  Created by Ritik Sharma on 18/08/23.
//

import UIKit

class MyWalletTVC: UITableViewCell {
    public static let reuseIdentifier: String = "MyWalletTVC"
    @IBOutlet weak var collectionView: UICollectionView!
    private var model: MyWalletTVCModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: MyWalletCVC.reuseIdentifier, bundle: .main), forCellWithReuseIdentifier: MyWalletCVC.reuseIdentifier)
    }

    func configure(with model: MyWalletTVCModel?) {
        if let model {
            self.model = model
            self.collectionView.reloadData()
        }
    }

}

extension MyWalletTVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 75)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.model?.sequenceData?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.model?.sequenceData?[indexPath.row] {
        case .wallet:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyWalletCVC.reuseIdentifier, for: indexPath) as? MyWalletCVC {
                cell.configure(with: self.model?.cardData(for: .wallet) as? MyWalletCVCModel)
                return cell
            }
        case .voucherNest:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyWalletCVC.reuseIdentifier, for: indexPath) as? MyWalletCVC {
                cell.configure(with: self.model?.cardData(for: .voucherNest) as? MyWalletCVCModel)
                return cell
            }
        default: return UICollectionViewCell()
        }
        return UICollectionViewCell()
    }
    
    
}
