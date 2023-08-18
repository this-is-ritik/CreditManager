//
//  ExploreVoucherTVC.swift
//  CreditManager
//
//  Created by Ritik Sharma on 18/08/23.
//

import UIKit

class ExploreVoucherTVC: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    public static let reuseIdentifier: String = "ExploreVoucherTVC"
    private var model: ExploreVoucherTVCModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        let nib = UINib(nibName: "ExploreVoucherCVC", bundle: .main)
        self.collectionView.register(nib, forCellWithReuseIdentifier: ExploreVoucherCVC.reuseIdentifier)
        
    }
    func configure(with model: ExploreVoucherTVCModel?) {
        if let model {
            self.model = model
            self.collectionView.reloadData()
        }
    }
}

extension ExploreVoucherTVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Int(collectionView.frame.width) / (self.model?.data?.count ?? 1) - 10 , height: 120)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.model?.data?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreVoucherCVC.reuseIdentifier, for: indexPath) as? ExploreVoucherCVC {
            cell.configure(with: self.model?.data?[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
