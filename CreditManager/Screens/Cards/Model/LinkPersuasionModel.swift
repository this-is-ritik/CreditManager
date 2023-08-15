//
//  LinkPersuasionModel.swift
//  CreditManager
//
//  Created by Ritik Sharma on 15/08/23.
//

import Foundation

class LinkPersuasionModel: BaseCardData {
    let sectionHeader: String?
    let cardData: LinkPersuasionCardData?

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.sectionHeader = try container.decodeIfPresent(String.self, forKey: .sectionHeader)
        self.cardData = try container.decodeIfPresent(LinkPersuasionCardData.self, forKey: .cardData)

        try super.init(from: decoder)
    }

    enum CodingKeys: String, CodingKey {
        case sectionHeader, cardData
    }
}

class LinkPersuasionCardData: Codable {
    let header: String?
    let bgColors: [String]?
    let subheader: String?
    let ctaText: String?
    let img: String?
}
