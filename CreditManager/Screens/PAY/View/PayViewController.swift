//
//  PayViewController.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import UIKit

class PayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    public static func controller() -> UIViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PayViewController") as? PayViewController
        return vc
    }
}
