//
//  HomeViewModel.swift
//  CreditManager
//
//  Created by Ritik Sharma on 15/08/23.
//

import Foundation

class HomeViewModel {
    
    var model: TableData?
    var delegate: HomeViewProtocol? = nil
    public init(model: TableData? = nil) {
        if let model {
            self.model = model
        }
        self.fetchDataFromApi() {
            self.delegate?.reloadHomeData()
        }
    }
    
    func fetchDataFromApi(closure: @escaping () -> Void) {
        guard let url = URL(string: "https://demo4627632.mockable.io/HomeData") else {return}
        var urlRequest = URLRequest(url: url, timeoutInterval: TimeInterval.init(integerLiteral: 30))
        urlRequest.httpMethod = "POST"
        URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            if let error {
                print("errror occurred: \(error.localizedDescription)")
            } else if let data {
                if let model = try? JSONDecoder().decode(HomeData.self, from: data) {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(data, forKey: Constants.homeDataKey)
                        self.model = model.tableData
                        closure()
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
    
    func sequenceData() -> [BaseCardData]? {
        self.model?.sequenceData
    }
    func cardData(for template: CreditCardTemplates) -> BaseCardData? {
        let cardData = HomeDataManager.shared.tableData?.apiData
        let decoder = JSONDecoder()
        if let data = try? JSONSerialization.data(withJSONObject: (cardData?.value as? [String: Any])?[template.rawValue] as Any, options: [.prettyPrinted, .fragmentsAllowed]) {
            switch template {
            case .amountDue:
                return try? decoder.decode(AmountDueCardModel.self, from: data)
            case .bankDue:
                return try? decoder.decode(BankDueCardModel.self, from: data)
            case .creditScore:
                return try? decoder.decode(CreditScoreModel.self, from: data)
            case .linkPersuasionCard:
                return try? decoder.decode(LinkPersuasionModel.self, from: data)
            }
        }
        return nil
    }
}
