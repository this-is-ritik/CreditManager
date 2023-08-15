//
//  HomeDataManager.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import Foundation

class HomeDataManager {
    public static let shared = HomeDataManager()
    private init() { }
    private var model: HomeData? {
        if let data = UserDefaults.standard.object(forKey: Constants.homeDataKey) as? Data {
            let model = try? JSONDecoder().decode(HomeData.self, from: data)
            return model
        }
        return nil
    }
    public var navBarData: NavBarModel? {
        self.model?.homeLayoutData.navBarData
    }
    public var tableData: TableData? {
        self.model?.tableData
    }
    public var tabBarData: TabBarModel? {
        self.model?.homeLayoutData.tabBarData
    }
}
