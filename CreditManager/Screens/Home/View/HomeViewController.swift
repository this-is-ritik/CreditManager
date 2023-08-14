//
//  HomeViewController.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadNavBar()
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
