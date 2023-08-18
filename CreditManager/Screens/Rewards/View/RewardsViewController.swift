//
//  RewardsViewController.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import UIKit

class RewardsViewController: UIViewController, RewardsViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    let viewModel: RewardsViewModel = RewardsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: ExploreVoucherTVC.reuseIdentifier, bundle: .main), forCellReuseIdentifier: ExploreVoucherTVC.reuseIdentifier)
        self.tableView.register(UINib(nibName: DealsTVC.reuseIdentifier, bundle: .main), forCellReuseIdentifier: DealsTVC.reuseIdentifier)
        self.tableView.register(UINib(nibName: CashTransferTVC.reuseIdentifier, bundle: .main), forCellReuseIdentifier: CashTransferTVC.reuseIdentifier)
        self.tableView.register(UINib(nibName: MyWalletTVC.reuseIdentifier, bundle: .main), forCellReuseIdentifier: MyWalletTVC.reuseIdentifier)
        
        self.viewModel.delegate = self
        self.viewModel.fetchDataFromApi()
        
    }
    
    public static func controller() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RewardsViewController") as? RewardsViewController
        return vc
    }
    func reloadRewardsData() {
        self.updateNavBar()
        self.tableView.reloadData()
    }
    
    func updateNavBar() {
        let leftBtn = UIBarButtonItem(title: self.viewModel.model?.title, style: .plain, target: nil, action: nil)
        leftBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)], for: .normal)
        leftBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)], for: .highlighted)
        self.navigationItem.leftBarButtonItem = leftBtn
        if let urlStr = self.viewModel.model?.img, let url = URL(string: urlStr) {
            ImageDownloader.shared.downloadImage(withURL: url, completion: { image in
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: nil)
            })
        }
    }
}


extension RewardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.viewModel.model?.sequenceData?[indexPath.section] {
        case .deals, .otherDeals: return 380
        case .voucher: return 120
        case .transferCash: return 120
        case .walletBalance: return 80
        default: return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch self.viewModel.model?.sequenceData?[section] {
        case .exploreCVC:
            return (self.viewModel.cardData(for: .exploreCVC) as? ExploreVoucherTVCModel)?.header
        default: return nil
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.noOfSection()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.noOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.viewModel.model?.sequenceData?[indexPath.section] {
        case .voucher:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ExploreVoucherTVC.reuseIdentifier, for: indexPath) as? ExploreVoucherTVC {
                cell.configure(with: self.viewModel.cardData(for: .voucher) as? ExploreVoucherTVCModel)
                return cell
            }
        case .deals:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DealsTVC.reuseIdentifier, for: indexPath) as? DealsTVC {
                cell.configure(with: self.viewModel.cardData(for: .deals) as? FeaturedTVCModel)
                return cell
            }
        case .otherDeals:
            if let cell = tableView.dequeueReusableCell(withIdentifier: DealsTVC.reuseIdentifier, for: indexPath) as? DealsTVC {
                cell.configure(with: self.viewModel.cardData(for: .otherDeals) as? FeaturedTVCModel)
                return cell
            }
        case .transferCash:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CashTransferTVC.reuseIdentifier, for: indexPath) as? CashTransferTVC {
                cell.configure(with: self.viewModel.cardData(for: .transferCash) as? CashTransferTVCModel)
                return cell
            }
        case .walletBalance:
            if let cell = tableView.dequeueReusableCell(withIdentifier: MyWalletTVC.reuseIdentifier, for: indexPath) as? MyWalletTVC {
                cell.configure(with: self.viewModel.cardData(for: .walletBalance) as? MyWalletTVCModel)
                return cell
            }
        default: return UITableViewCell()
        }
        return UITableViewCell()
    }
}
