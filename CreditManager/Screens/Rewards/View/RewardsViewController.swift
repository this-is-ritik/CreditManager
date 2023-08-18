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
        self.title = "REWARDS"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: ExploreVoucherTVC.reuseIdentifier, bundle: .main), forCellReuseIdentifier: ExploreVoucherTVC.reuseIdentifier)
        self.tableView.register(UINib(nibName: DealsTVC.reuseIdentifier, bundle: .main), forCellReuseIdentifier: DealsTVC.reuseIdentifier)
        self.tableView.register(UINib(nibName: CashTransferTVC.reuseIdentifier, bundle: .main), forCellReuseIdentifier: CashTransferTVC.reuseIdentifier)
        self.viewModel.delegate = self
        self.viewModel.fetchDataFromApi()
        
    }
    
    public static func controller() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RewardsViewController") as? RewardsViewController
        return vc
    }
    func reloadRewardsData() {
        self.tableView.reloadData()
    }
    
}


extension RewardsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.viewModel.model?.sequenceData?[indexPath.section] {
        case .deals, .otherDeals: return 380
        case .voucher: return 120
        case .transferCash: return 120
        default: return .zero
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
        default: return UITableViewCell()
        }
        return UITableViewCell()
    }
}
