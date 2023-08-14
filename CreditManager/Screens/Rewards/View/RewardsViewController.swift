//
//  RewardsViewController.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import UIKit

class RewardsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "REWARDS"
        
    }
    
    public static func controller() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RewardsViewController") as? RewardsViewController
        return vc
    }
}
