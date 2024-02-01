//
//  DIContainer.swift
//  LMessenger
//
//  Created by 김민준 on 2/1/24.
//

import Foundation

/// EnvironmentObject로 서비스 전반에 사용할 예정
class DIContainer: ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
