//
//  RewardsModel.swift
//  CreditManager
//
//  Created by Ritik Sharma on 17/08/23.
//

import Foundation


protocol RewardsModelProtocol: AnyObject {
    var template: RewardsCardTemplates? { get }
}
class RewardsBaseData: Codable, RewardsModelProtocol {
    var template: RewardsCardTemplates? = nil
}
class RewardsModel: Codable {
    var title: String?
    var img: String?
    var sequenceData: [RewardsCardTemplates]? = nil
    var data: JsonCodableValue? = nil
}

class RewardsCardData: Codable {
    let template: RewardsCardTemplates?
    let data: JsonCodableValue?
}
