//
//  RewardsViewModel.swift
//  CreditManager
//
//  Created by Ritik Sharma on 17/08/23.
//

import Foundation

protocol RewardsViewProtocol: AnyObject {
    func reloadRewardsData()
}

class RewardsViewModel: NSObject {
    var delegate: RewardsViewProtocol?
    var model: RewardsModel? {
        didSet {
            self.delegate?.reloadRewardsData()
        }
    }
    private let url = URL(string: "https://demo4627632.mockable.io/RewardsData")!
    func fetchDataFromApi() {
        var urlRequest = URLRequest(url: self.url, timeoutInterval: TimeInterval.init(integerLiteral: 30))
        urlRequest.httpMethod = "POST"
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let error {
                print("errror occurred: \(error.localizedDescription)")
            } else if let data {
                if let model = try? JSONDecoder().decode(RewardsModel.self, from: data) {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(data, forKey: Constants.rewardsDataKey)
                        self.model = model
                    }
                }
            }
        }).resume()
    }
    func noOfSection() -> Int {
        return self.model?.sequenceData?.count ?? .zero
    }
    
    func noOfRowsInSection() -> Int {
        return 1
    }
    
    func sequenceData() -> [RewardsCardTemplates]? {
        self.model?.sequenceData
    }
    func cardData(for template: RewardsCardTemplates) -> RewardsTVCModel? {
        let decoder = JSONDecoder()
        if let data = try? JSONSerialization.data(withJSONObject: ((self.model?.data?.value as? [String: Any])?[template.rawValue] as? [String: Any]) as Any, options: [.prettyPrinted, .fragmentsAllowed]) {
            switch template {
            case .voucher:
                return try? decoder.decode(ExploreVoucherTVCModel.self, from: data)
            case .deals, .otherDeals:
                return try? decoder.decode(FeaturedTVCModel.self, from: data)
            case .transferCash:
                return try? decoder.decode(CashTransferTVCModel.self, from: data)
            default: return nil
            }
        }
        return nil
    }

}
