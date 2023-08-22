//
//  AmountDueCardTVC.swift
//  CreditManager
//
//  Created by Ritik Sharma on 15/08/23.
//

import UIKit

class AmountDueCardTVC: UITableViewCell {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomCta: UIButton!
    
    @IBOutlet weak var bottomBgView: UIView!
    @IBOutlet weak var bgView: UIView!
    static let reuseIdentifier: String = "AmountDueCardTVC"
    private var model: AmountDueCardModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.register(UINib(nibName: "BankDueCard", bundle: .main), forCellReuseIdentifier: BankDueCardTVC.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.bgView.layer.borderWidth = 1
        self.bottomBgView.layer.borderWidth = 1
        self.bottomBgView.layer.borderColor = UIColor(red: 0.416, green: 0.451, blue: 0.506, alpha: 0.12).cgColor
        self.bgView.layer.borderColor = UIColor(red: 0.416, green: 0.451, blue: 0.506, alpha: 0.12).cgColor
        self.bgView.layer.cornerRadius = 16
        self.bottomBgView.layer.cornerRadius = 16
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func configure(with model: AmountDueCardModel?) {
        self.bottomCta.titleLabel?.textAlignment = .center
        self.bottomCta.setAttributedTitle(NSAttributedString(string: model?.sectionData?.ctaText ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor(hex: model?.sectionData?.textColor)]), for: .normal)
        
        self.bottomCta.layer.cornerRadius = 16
        self.bottomCta.tintColor = UIColor(hex: model?.sectionData?.bgColor)
        self.bottomCta.addGradientColorWithCornerRadius(withColors: [UIColor(hex: model?.sectionData?.bgColor)], withType: .linear(startPoint: .zero, endPoint: .init(x: 1.0, y: 1.0)))
        if let urlStr = model?.sectionData?.ctaImg, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.bottomCta.setImage(image?.resizeImage(newWidth: 14), for: .normal)
            })
        }
        if let model {
            self.model = model
            self.tableView.reloadData()
        }
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addGradientColorWithCornerRadius(withColors: [UIColor(hex: "#FAF8F8"), UIColor(hex: "#FFE3E3")], withType: .linear(startPoint: .init(x: 0.5, y: 0), endPoint: .init(x: 0.5, y: 1.0)))
    }
}


extension AmountDueCardTVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        let labelLeft = UILabel()
        labelLeft.text = model?.sectionData?.headerText
        labelLeft.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        labelLeft.textColor = .black
        
        let labelRight = UILabel()
        labelRight.text = model?.sectionData?.totalAmount
        labelRight.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        labelRight.textColor = .black
        
        let separatorView = UIView()
        separatorView.backgroundColor = UIColor(hex: "#E6EAE9")
        
        view.addSubview(labelLeft)
        view.addSubview(labelRight)
        view.addSubview(separatorView)
        
        labelLeft.translatesAutoresizingMaskIntoConstraints = false
        labelRight.translatesAutoresizingMaskIntoConstraints = false
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            labelLeft.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelLeft.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            labelRight.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelRight.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            labelRight.leadingAnchor.constraint(greaterThanOrEqualTo: labelLeft.trailingAnchor, constant: 10),
            
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model?.bankDueCardData?.count ?? .zero
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.model?.bankDueCardData?[indexPath.row].template {
        case .bankDue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: BankDueCardTVC.reuseIdentifier) as? BankDueCardTVC {
                cell.configure(with: self.model?.bankDueCardData?[indexPath.row] as? BankDueCardModel)
                cell.layoutIfNeeded()
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}
