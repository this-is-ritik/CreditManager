//
//  BankDueCardModel.swift
//  CreditManager
//
//  Created by Ritik Sharma on 15/08/23.
//

import Foundation

class BankDueCardModel: BaseCardData {
    
    let img: String?
    let bankName: String?
    let cardType: String?
    let amount: String?
    let pendingDaysStatus: String?
    let textColor: String?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.img = try container.decodeIfPresent(String.self, forKey: .img)
        self.bankName = try container.decodeIfPresent(String.self, forKey: .bankName)
        self.cardType = try container.decodeIfPresent(String.self, forKey: .cardType)
        self.amount = try container.decodeIfPresent(String.self, forKey: .amount)
        self.pendingDaysStatus = try container.decodeIfPresent(String.self, forKey: .pendingDaysStatus)
        self.textColor = try container.decodeIfPresent(String.self, forKey: .textColor)

        try super.init(from: decoder)
    }
    enum CodingKeys: CodingKey {
        case img, bankName, cardType, amount, pendingDaysStatus, textColor
    }
}

