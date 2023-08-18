//
//  RewardsCardTemplates.swift
//  CreditManager
//
//  Created by Ritik Sharma on 17/08/23.
//

import Foundation

enum RewardsCardTemplates: String, Codable {
    case voucher = "VOUCHERS_EXPLORE"
    case transferCash = "CASH_TRANSFER"
    case walletBalance = "WALLET_BALANCE"
    case deals = "FEATURED_DEALS"
    case otherDeals = "OTHER_FEATURED_DEALS"
    case exploreCVC = "EXPLORE_VOUCHER_CVC"
    case wallet = "WALLET"
    case voucherNest = "VOUCHER_NEST"
}
