//
//  FeaturedDealsModel.swift
//  CreditManager
//
//  Created by Ritik Sharma on 18/08/23.
//

import Foundation

class FeaturedTVCModel: RewardsTVCModel {
    var header: String?
    var bgImg: String?
    var bgColor: String?
    var chipsImg: String?
    var persuasionText: String?
    var data: [FeaturedCVCModel]?
    
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.header = try container.decodeIfPresent(String.self, forKey: .header)
            self.bgImg = try container.decodeIfPresent(String.self, forKey: .bgImg)
            self.bgColor = try container.decodeIfPresent(String.self, forKey: .bgColor)
            self.chipsImg = try container.decodeIfPresent(String.self, forKey: .chipsImg)
            self.persuasionText = try container.decodeIfPresent(String.self, forKey: .persuasionText)
            self.data = try container.decodeIfPresent([FeaturedCVCModel].self, forKey: .data)
            try super.init(from: decoder)
        }
        
    enum CodingKeys: String, CodingKey {
        case header, data, bgImg, bgColor, chipsImg, persuasionText
    }
}

class FeaturedCVCModel: Codable {
    var merchLogo: String?
    var header: String?
    var persuasionText: String?
    var chipsImg: String?
    var bottomImg: String?
    var text: String?
    var bgColor: String?
}
