//
//  HomeData.swift
//  CreditManager
//
//  Created by Ritik Sharma on 13/08/23.
//

import Foundation


class HomeData: Codable {
    let apiData: ApiData
    let homeLayoutData: HomeLayoutData
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.apiData = try container.decodeIfPresent(ApiData.self, forKey: .apiData) ?? .init()
        self.homeLayoutData = try container.decodeIfPresent(HomeLayoutData.self, forKey: .homeLayoutData) ?? .init()
    }
    
    enum CodingKeys: String, CodingKey {
        case homeLayoutData = "HOME_LAYOUT_DATA"
        case apiData
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

class ApiData: Codable {
    
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
}
