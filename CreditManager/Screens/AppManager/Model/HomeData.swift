//
//  HomeData.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import Foundation

protocol BaseCardDataProtocol: AnyObject, Codable {
    var template: CreditCardTemplates { get }
}

class BaseCardData: BaseCardDataProtocol, Codable {
    var template: CreditCardTemplates
    init(template: CreditCardTemplates) {
        self.template = template
    }
}
class HomeData: Codable {
    let tableData: TableData?
    let homeLayoutData: HomeLayoutData
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tableData = try container.decodeIfPresent(TableData.self, forKey: .tableData)
        self.homeLayoutData = try container.decodeIfPresent(HomeLayoutData.self, forKey: .homeLayoutData) ?? .init()
    }
    
    enum CodingKeys: String, CodingKey {
        case homeLayoutData = "HOME_LAYOUT_DATA"
        case tableData = "TABLE_DATA"
    }
}

class HomeLayoutData: Codable {
    var tabBarData: TabBarModel? = nil
    var navBarData: NavBarModel? = nil
    
    init() {
        self.tabBarData = nil
        self.navBarData = nil
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.tabBarData = try container.decodeIfPresent(TabBarModel.self, forKey: .tabBarData)
        self.navBarData = try container.decodeIfPresent(NavBarModel.self, forKey: .navBarData)
    }
    
    enum CodingKeys: String, CodingKey {
        case tabBarData = "TAB_BAR_DATA"
        case navBarData = "NAV_BAR_DATA"
    }
}

class TableData: Codable {
    let sequenceData: [BaseCardData]?
    let apiData: JsonCodableValue?

    init(sequenceData: [BaseCardData]? = nil, apiData: JsonCodableValue? = nil) {
        self.sequenceData = sequenceData
        self.apiData = apiData
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sequenceData = try container.decodeIfPresent([BaseCardData].self, forKey: .sequenceData)
        self.apiData = try container.decodeIfPresent(JsonCodableValue.self, forKey: .apiData)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(sequenceData, forKey: .sequenceData)
        try container.encodeIfPresent(apiData, forKey: .apiData)
    }

    enum CodingKeys: String, CodingKey {
        case sequenceData
        case apiData
    }
}


class TabBarModel: Codable {
    let screens: [ScreenData]
    let selected: Int
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.screens = try container.decodeIfPresent([ScreenData].self, forKey: .screens) ?? []
        self.selected = try container.decodeIfPresent(Int.self, forKey: .selected) ?? .zero
    }
}

class ScreenData: Codable {
    let title: String?
    let img: String?
    let selectedImg: String?
    let templateId: VCTemplate
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.img = try container.decodeIfPresent(String.self, forKey: .img)
        self.selectedImg = try container.decodeIfPresent(String.self, forKey: .selectedImg)
        self.templateId = try container.decodeIfPresent(VCTemplate.self, forKey: .templateId) ?? .HomeVC
    }
}

class NavBarModel: Codable {
    let leftContent: LeftContent?
    let rightContent: RightContent?
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.leftContent = try container.decodeIfPresent(LeftContent.self, forKey: .leftContent) ?? .init()
        self.rightContent = try container.decodeIfPresent(RightContent.self, forKey: .rightContent) ?? .init()
    }
}

class LeftContent: Codable {
    let title: String?
    init(title: String? = nil) {
        self.title = title
    }
}


class RightContent: Codable {
    let ctaButtons: [NavBarButton]
    init(ctaButtons: [NavBarButton] = []) {
        self.ctaButtons = ctaButtons
    }
}

class NavBarButton: Codable {
    let title: String?
    let cornerRadius: CGFloat?
    let img: String?
    let borderColor: String?
}



enum JsonCodableValue: Codable, Equatable {
    case string(String)
    case int(Int)
    case double(Double)
    case bool(Bool)
    case dictionary([String: JsonCodableValue])
    case array([JsonCodableValue])
    case unknown
        
    public static func == (lhs: JsonCodableValue, rhs: JsonCodableValue) -> Bool {
        switch (lhs, rhs) {
        case (.string(let lhsValue), .string(let rhsValue)):
            return lhsValue == rhsValue
        case (.int(let lhsValue), .int(let rhsValue)):
            return lhsValue == rhsValue
        case (.double(let lhsValue), .double(let rhsValue)):
            return lhsValue == rhsValue
        case (.bool(let lhsValue), .bool(let rhsValue)):
            return lhsValue == rhsValue
        case (.dictionary(let lhsValue), .dictionary(let rhsValue)):
            return lhsValue == rhsValue
        case (.array(let lhsValue), .array(let rhsValue)):
            return lhsValue == rhsValue
        case (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(String.self) {
            self = .string(value)
        } else if let value = try? container.decode(Int.self) {
            self = .int(value)
        } else if let value = try? container.decode(Double.self) {
            self = .double(value)
        } else if let value = try? container.decode(Bool.self) {
            self = .bool(value)
        } else if let value = try? container.decode([String: JsonCodableValue].self) {
            self = .dictionary(value)
        } else if let value = try? container.decode([JsonCodableValue].self) {
            self = .array(value)
        } else {
            self = .unknown // For null values
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .string(let value):
            try? container.encode(value)
        case .int(let value):
            try? container.encode(value)
        case .dictionary(let value):
            try? container.encode(value)
        case .double(let value):
            try? container.encode(value)
        case .bool(let value):
            try? container.encode(value)
        case .array(let value):
            try? container.encode(value)
        case .unknown:
            try? container.encodeNil()
        }
    }
    
    public var value: Any? {
        switch self {
        case .string(let value): return value
        case .int(let value): return value
        case .dictionary(let value): return value.compactMapValues { $0.value }
        case .double(let value): return value
        case .bool(let value): return value
        case .array(let value): return value.compactMap { $0.value }
        case .unknown: return nil
        }
    }
    
    public static func codableType(with value: Any) -> JsonCodableValue? {
        switch value {
        case let intValue as Int:
            return JsonCodableValue.int(intValue)
        case let stringValue as String:
            return JsonCodableValue.string(stringValue)
        case let boolValue as Bool:
            return JsonCodableValue.bool(boolValue)
        case let doubleValue as Double:
            return JsonCodableValue.double(doubleValue)
        case let dict as [String: Any]:
            return JsonCodableValue.dictionary(dict.compactMapValues({ JsonCodableValue.codableType(with: $0) }))
        case let arrayValue as [[String: Any]]:
            return JsonCodableValue.array(arrayValue.compactMap({ JsonCodableValue.codableType(with: $0) }))
        case let arrayValue as [Any]:
            return JsonCodableValue.array(arrayValue.compactMap({ JsonCodableValue.codableType(with: $0) }))
        default:
            return nil
        }
    }
}

extension Dictionary where Value == JsonCodableValue {
    
    internal func toDictionary() -> [Key: Any]? {
        compactMapValues { $0.value }
    }
    
}

extension Array where Element == JsonCodableValue {
    
    internal func toArray() -> [Any]? {
        compactMap { $0.value }
    }
    
}

extension Dictionary {
    public func discardNull() -> Dictionary {
        return self.compactMapValues {
            if $0 is NSNull {
                return nil
            } else if let _values = $0 as? Dictionary {
                return _values.discardNull() as? Value
            } else if let _values = $0 as? [Any] {
                return _values.discardNull() as? Value
            } else {
                return $0
            }
        }
    }
}
extension Array {
    public func discardNull() -> Array {
        return self.compactMap({
            if $0 is NSNull {
                return nil
            } else if let _values = $0 as? [String: Any] {
                return _values.discardNull() as? Element
            } else {
                return $0
            }
        })
    }
}

