//
//  DealsTVC.swift
//  CreditManager
//
//  Created by Ritik Sharma on 18/08/23.
//

import UIKit

class DealsTVC: UITableViewCell {

    @IBOutlet weak var bgImgView: UIImageView!
    
    @IBOutlet weak var bgView: UIView!
    
    
    @IBOutlet weak var headerLbkl: UILabel!
    
    @IBOutlet weak var rightCtaView: UIView!
    
    @IBOutlet weak var rightCta: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var model: FeaturedTVCModel?
    public static let reuseIdentifier: String = "DealsTVC"
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: DealsCVC.reuseIdentifier, bundle: .main), forCellWithReuseIdentifier: DealsCVC.reuseIdentifier)
        self.rightCtaView.layer.cornerRadius = 13
        self.rightCta.backgroundColor = .white
        self.contentView.backgroundColor = UIColor(hex: "#FFEEB2")
        self.rightCtaView.backgroundColor = UIColor(red: 0.894, green: 0.737, blue: 0.2, alpha: 1)
        self.rightCta.layer.cornerRadius = 13
        self.rightCta.tintColor = UIColor(hex: "#49505A")
        self.headerLbkl.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        self.headerLbkl.textColor = UIColor(red: 0.431, green: 0.442, blue: 0.438, alpha: 1)
    }

    func configure(with model: FeaturedTVCModel?) {
        if let model {
            self.model = model
            self.collectionView.reloadData()
        }
        if let urlStr = model?.bgImg, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.bgImgView.image = image?.withTintColor(UIColor.systemOrange)
            })
        }
        if let urlStr = model?.chipsImg, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.rightCta.setImage(image?.resizeImage(newWidth: 16), for: .normal)
                self.rightCta.setImage(image?.resizeImage(newWidth: 16), for: .highlighted)
            })
        }
        if let hex = model?.bgColor {
            self.bgView.backgroundColor = UIColor(hex: hex)
            self.contentView.backgroundColor = .clear
        } else {
            self.bgView.backgroundColor = .clear
        }
        self.headerLbkl.text = model?.header
        if let text = model?.persuasionText {
            self.rightCta.isHidden = false
            self.rightCtaView.isHidden = false
            self.rightCta.setTitle(text, for: .normal)
        } else {
            self.rightCta.isHidden = true
            self.rightCtaView.isHidden = true
        }
    }
}

extension DealsTVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 270)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model?.data?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DealsCVC.reuseIdentifier, for: indexPath) as? DealsCVC {
            cell.configure(with: self.model?.data?[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
