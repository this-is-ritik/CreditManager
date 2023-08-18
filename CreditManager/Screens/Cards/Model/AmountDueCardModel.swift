//
//  AmountDueCardModel.swift
//  CreditManager
//
//  Created by Ritik Sharma on 15/08/23.
//

import Foundation

class AmountDueCardModel: BaseCardData {
    let sectionData: SectionData?
    let bankDueCardData: [BankDueCardModel]?
    enum CodingKeys: String, CodingKey {
        case sectionData
        case bankDueCardData
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sectionData = try container.decodeIfPresent(SectionData.self, forKey: .sectionData)
        bankDueCardData = try container.decodeIfPresent([BankDueCardModel].self, forKey: .bankDueCardData)
        try super.init(from: decoder)
    }
}

class SectionData: Codable {
    let headerText: String?
    let totalAmount: String?
    let ctaText: String?
    let ctaImg: String?
    let textColor: String?
    let bgColor: String?
    
}
