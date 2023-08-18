//
//  ExploreVoucherModel.swift
//  CreditManager
//
//  Created by Ritik Sharma on 18/08/23.
//

import Foundation
class RewardsTVCModel: Codable {
}


class ExploreVoucherTVCModel: RewardsTVCModel {
    var header: String?
    var data: [ExploreVoucherCVCModel]?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.header = try container.decodeIfPresent(String.self, forKey: .header)
        self.data = try container.decodeIfPresent([ExploreVoucherCVCModel].self, forKey: .data)
        try super.init(from: decoder)
    }
    enum CodingKeys: String, CodingKey {
        case header, data
    }
}

class ExploreVoucherCVCModel: Codable {
    var img: String?
    var title: String?
}
