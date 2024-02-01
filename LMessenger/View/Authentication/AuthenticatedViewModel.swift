//
//  AuthenticatedViewModel.swift
//  LMessenger
//
//  Created by 김민준 on 2/1/24.
//

import Foundation

enum AuthenticationState {
    case unAuthenticated
    case authenticated
}

class AuthenticatedViewModel: ObservableObject {
    
    @Published var authenticationState: AuthenticationState = .unAuthenticated
    
    private var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
