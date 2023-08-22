//
//  HomeViewController.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import UIKit
protocol HomeViewProtocol: AnyObject {
    func reloadHomeData()
}
class HomeViewController: UIViewController, HomeViewProtocol {
    func reloadHomeData() {
        self.tableView.reloadData()
    }
    

    @IBOutlet weak var tableView: UITableView!
    public var viewModel: HomeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HomeViewModel(model: HomeDataManager.shared.tableData)
        self.viewModel.delegate = self
        self.registerCells()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadNavBar()
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func registerCells() {
        self.tableView.register(UINib(nibName: "AmountDueCard", bundle: .main), forCellReuseIdentifier: AmountDueCardTVC.reuseIdentifier)
        self.tableView.register(UINib(nibName: "CreditScoreCard", bundle: .main), forCellReuseIdentifier: CreditScoreCardTVC.reuseIdentifier)
        self.tableView.register(UINib(nibName: "LinkPersuasionCard", bundle: .main), forCellReuseIdentifier: LinkPersuasionCardTVC.reuseIdentifier)
    }
    public static func controller() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
        return vc
    }

    private func reloadNavBar() {
        if let model = HomeDataManager.shared.navBarData {
            // left content update
            if let title = model.leftContent?.title {
                let lbl = UILabel()
                lbl.text = title
                let leftButton = UIBarButtonItem(customView: lbl)
                leftButton.tintColor = UIColor.black
                self.navigationItem.setLeftBarButtonItems([leftButton], animated: true)
            }
            // right content update
            var rightButtons: [UIBarButtonItem] = []
            if let profileView = Bundle.main.loadNibNamed("ProfileNavBarView", owner: self)?.first as? ProfileNavBarView {
                profileView.configureView(with: model.rightContent?.ctaButtons.last)
                let btn = UIBarButtonItem(customView: profileView)
                rightButtons.append(btn)
            }
            if let wltView = Bundle.main.loadNibNamed("WalletNavBarView", owner: self)?.first as? WalletNavBarView {
                wltView.configure(with: model.rightContent?.ctaButtons.first)
                let btn = UIBarButtonItem(customView: wltView)
                rightButtons.append(btn)
            }
            self.navigationItem.setRightBarButtonItems(rightButtons, animated: true)
        }
    }

}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.viewModel.sequenceData()?[indexPath.section].template {
        case .amountDue:
            return 320
        case .creditScore:
            return 70
        default:
            return UITableView.automaticDimension
        }
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch self.viewModel.sequenceData()?[section].template {
        case .creditScore: return 40
        case .linkPersuasionCard: return 40
        case .amountDue: return 0
        default: return 20
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white // Set your desired background color
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        titleLabel.textColor = UIColor(hex: "#6E7170")
        switch self.viewModel.sequenceData()?[section].template {
        case .creditScore:
            titleLabel.text = (self.viewModel.cardData(for: .creditScore) as? CreditScoreModel)?.sectionHeader
        case .linkPersuasionCard:
            titleLabel.text = (self.viewModel.cardData(for: .linkPersuasionCard) as? LinkPersuasionModel)?.sectionHeader
        default:
            titleLabel.text = nil
        }
        
        headerView.addSubview(titleLabel)
        
        // Add constraints to position titleLabel within headerView
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0)
        ])
        
        return headerView
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.noOfSection()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.noOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.viewModel.sequenceData()?[indexPath.section].template {
        case .amountDue:
            if let cell = tableView.dequeueReusableCell(withIdentifier: AmountDueCardTVC.reuseIdentifier) as? AmountDueCardTVC {
                cell.backgroundColor = .clear
                cell.configure(with: self.viewModel.cardData(for: .amountDue) as? AmountDueCardModel)
                cell.layoutIfNeeded()
                return cell
            }
        case .creditScore:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CreditScoreCardTVC.reuseIdentifier) as? CreditScoreCardTVC {
                cell.backgroundColor = .clear
                    cell.configure(with: self.viewModel.cardData(for: .creditScore) as? CreditScoreModel)
                return cell
            }
        case .linkPersuasionCard:
            if let cell = tableView.dequeueReusableCell(withIdentifier: LinkPersuasionCardTVC.reuseIdentifier) as? LinkPersuasionCardTVC {
                cell.backgroundColor = .clear
                        cell.configure(with: self.viewModel.cardData(for: .linkPersuasionCard) as? LinkPersuasionModel)
                cell.setNeedsLayout()
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
}
