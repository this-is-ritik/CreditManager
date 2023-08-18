//
//  MyWalletCVCModel.swift
//  CreditManager
//
//  Created by Ritik Sharma on 18/08/23.
//

import Foundation

class MyWalletTVCModel: RewardsTVCModel {
    
    let sequenceData: [RewardsCardTemplates]?
    let data: JsonCodableValue?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sequenceData = try container.decodeIfPresent([RewardsCardTemplates].self, forKey: .sequenceData)
        self.data = try container.decodeIfPresent(JsonCodableValue.self, forKey: .data)

        try super.init(from: decoder)
    }
    
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(sequenceData, forKey: .sequenceData)
        try container.encodeIfPresent(sequenceData, forKey: .data)
        try super.encode(to: encoder) 
    }
    
    private enum CodingKeys: String, CodingKey {
        case sequenceData, data
    }
    
    func cardData(for template: RewardsCardTemplates) -> RewardsTVCModel? {
        let decoder = JSONDecoder()
        if let data = try? JSONSerialization.data(withJSONObject: (self.data?.value as? [String: Any])?[template.rawValue] as Any, options: [.prettyPrinted, .fragmentsAllowed]) {
            switch template {
            case .wallet, .voucherNest:
                return try? decoder.decode(MyWalletCVCModel.self, from: data)
            default: return nil
            }
        }
        return nil
    }
}

class MyWalletCVCModel: RewardsTVCModel {
    let header: String?
    let img: String?
    let rightImg: String?
    let title: String?
    let subTitle: String?
    let subTitleColor: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.header = try container.decodeIfPresent(String.self, forKey: .header)
        self.img = try container.decodeIfPresent(String.self, forKey: .img)
        self.rightImg = try container.decodeIfPresent(String.self, forKey: .rightImg)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.subTitle = try container.decodeIfPresent(String.self, forKey: .subTitle)
        self.subTitleColor = try container.decodeIfPresent(String.self, forKey: .subTitleColor)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(header, forKey: .header)
        try container.encodeIfPresent(img, forKey: .img)
        try container.encodeIfPresent(img, forKey: .rightImg)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(subTitle, forKey: .subTitle)
        try container.encodeIfPresent(subTitleColor, forKey: .subTitleColor)
        try super.encode(to: encoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case header, img, rightImg,title, subTitle, subTitleColor
    }
}
