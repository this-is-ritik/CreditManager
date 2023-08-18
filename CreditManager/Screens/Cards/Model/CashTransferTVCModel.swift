//
//  CashTransferTVCModel.swift
//  CreditManager
//
//  Created by Ritik Sharma on 18/08/23.
//

import Foundation

class CashTransferTVCModel: RewardsTVCModel {
    var header: String?
    var subheader: String?
    var arrowTintColor: String?
    var chipsImg: String?
    var persuasionText: String?
    var img: String?
    var bgColor: String?
    
    required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.header = try container.decodeIfPresent(String.self, forKey: .header)
            self.subheader = try container.decodeIfPresent(String.self, forKey: .subheader)
            self.arrowTintColor = try container.decodeIfPresent(String.self, forKey: .arrowTintColor)
            self.chipsImg = try container.decodeIfPresent(String.self, forKey: .chipsImg)
            self.persuasionText = try container.decodeIfPresent(String.self, forKey: .persuasionText)
            self.img = try container.decodeIfPresent(String.self, forKey: .img)
            self.bgColor = try container.decodeIfPresent(String.self, forKey: .bgColor)
            try super.init(from: decoder)
        }
        
    enum CodingKeys: String, CodingKey {
        case header, subheader, arrowTintColor, persuasionText, chipsImg, bgColor, img
    }
}
