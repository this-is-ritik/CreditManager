//
//  Constants.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import Foundation

class Constants {
    public static let homeDataKey: String = "HomeData"
    public static let rewardsDataKey: String = "RewardData"
    
}

public enum VCTemplate: String, Codable {
    case HomeVC = "HOME"
    case PAY = "PAY"
    case REWARDS = "REWARDS"
}
