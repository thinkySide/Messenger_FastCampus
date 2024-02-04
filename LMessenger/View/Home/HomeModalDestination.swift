//
//  HomeModalDestination.swift
//  LMessenger
//
//  Created by 김민준 on 2/4/24.
//

import Foundation

enum HomeModalDestination: Hashable, Identifiable {
    case myProfile
    case otherProfile(String)
    
    var id: Int {
        hashValue
    }
}
