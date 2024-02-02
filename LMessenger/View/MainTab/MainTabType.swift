//
//  MainTabType.swift
//  LMessenger
//
//  Created by 김민준 on 2/2/24.
//

import Foundation

enum MainTabType: String, CaseIterable {
    case home
    case chat
    case phone
    
    var title: String {
        switch self {
        case .home: return "홈"
        case .chat: return "대화"
        case .phone: return "통화"
        }
    }
    
    func imageName(selected: Bool) -> String {
        return selected ? "\(rawValue)_fill" : rawValue
    }
}
