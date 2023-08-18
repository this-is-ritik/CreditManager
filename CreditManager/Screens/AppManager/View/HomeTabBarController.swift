//
//  HomeTabBarController.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import UIKit

class HomeTabBarController: UITabBarController, UITabBarControllerDelegate {

    private var homeDataModel: HomeData? = nil
    private var tabBarVCs: [UIViewController] = []
    private var selectedInd: Int = .zero
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        self.tabBar.backgroundColor = UIColor.white
        self.delegate = self
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        self.homeApiCall()
    }
    
    private func updateOnApiSuccess() {
        self.reloadTabBar()
        UIView.animate(withDuration: 0.6, delay: .zero, options: .curveEaseInOut, animations: {
            self.setViewControllers(self.tabBarVCs, animated: false)
            self.selectedIndex = self.selectedInd
        })
    }
    private func reloadTabBar() {
        if let model = self.homeDataModel?.homeLayoutData.tabBarData {
            var viewControllers: [UIViewController] = []
            for (index, screen) in model.screens.enumerated() {
                
                // get vc from templateid
                if let vc = self.getViewController(from: screen.templateId) {
                    
                    // create a tabbar item for that vc
                    let item = UITabBarItem(title: screen.title, image: UIImage(named: screen.img ?? "HOME", in: .main, with: nil)?.withRenderingMode(.alwaysOriginal), tag: index)
                    print(screen.selectedImg)
                    item.selectedImage = UIImage(named: (screen.selectedImg ?? "Rewards_selected"), in: .main, with: nil)?.withRenderingMode(.alwaysOriginal)
                    
                    vc.tabBarItem = item
                    
                    viewControllers.append(UINavigationController(rootViewController: vc))
                }
            }
            self.tabBarVCs = viewControllers
            self.selectedInd = model.selected
        }
    }
    private func homeApiCall() {
        guard let url = URL(string: "https://demo4627632.mockable.io/HomeData") else {return}
        var urlRequest = URLRequest(url: url, timeoutInterval: TimeInterval.init(integerLiteral: 30))
        urlRequest.httpMethod = "POST"
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let error {
                print("errror occurred: \(error.localizedDescription)")
            } else if let data {
                if let model = try? JSONDecoder().decode(HomeData.self, from: data) {
                    DispatchQueue.main.async {
                        self.homeDataModel = model
                        UserDefaults.standard.set(data, forKey: Constants.homeDataKey)
                        self.updateOnApiSuccess()
                    }
                }
            }
        }).resume()
    }

}

extension HomeTabBarController {
    private func getViewController(from templateId: VCTemplate) -> UIViewController? {
        switch templateId {
        case .HomeVC:
            return HomeViewController.controller()
        case .PAY:
            return PayViewController.controller()
        case .REWARDS:
            return RewardsViewController.controller()
        }
    }
}
