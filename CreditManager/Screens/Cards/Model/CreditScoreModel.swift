//
//  CreditScoreModel.swift
//  CreditManager
//
//  Created by Ritik Sharma on 15/08/23.
//

import Foundation

class CreditScoreModel: BaseCardData {
    let sectionHeader: String
    let img: String?
    let score: String?
    let maxScore: String?
    let scoreStatus: String?
    let scoreStatusColor: String?
    let providerText: String?
    let providerImg: String?
    let arrowColor: String?

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.sectionHeader = try container.decode(String.self, forKey: .sectionHeader)
        self.img = try container.decodeIfPresent(String.self, forKey: .img)
        self.score = try container.decodeIfPresent(String.self, forKey: .score)
        self.maxScore = try container.decodeIfPresent(String.self, forKey: .maxScore)
        self.scoreStatus = try container.decodeIfPresent(String.self, forKey: .scoreStatus)
        self.scoreStatusColor = try container.decodeIfPresent(String.self, forKey: .scoreStatusColor)
        self.providerText = try container.decodeIfPresent(String.self, forKey: .providerText)
        self.providerImg = try container.decodeIfPresent(String.self, forKey: .providerImg)
        self.arrowColor = try container.decodeIfPresent(String.self, forKey: .arrowColor)
        try super.init(from: decoder)
    }

    enum CodingKeys: String, CodingKey {
        case sectionHeader, img, score, maxScore, scoreStatus, scoreStatusColor, providerText, providerImg, template, arrowColor
    }
}
