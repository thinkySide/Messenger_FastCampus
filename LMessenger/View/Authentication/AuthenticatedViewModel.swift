//
//  AuthenticatedViewModel.swift
//  LMessenger
//
//  Created by 김민준 on 2/1/24.
//

import Foundation
import Combine

enum AuthenticationState {
    case unAuthenticated
    case authenticated
}

class AuthenticatedViewModel: ObservableObject {
    
    enum Action {
        case googleLogin
    }
    
    @Published var authenticationState: AuthenticationState = .unAuthenticated
    
    var userID: String?
    
    private var container: DIContainer
    
    /// 여기 모든 구독권들이 추가되어 관리 할 수 있게 됨!
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .googleLogin:
            container.services.authService.signInWithGoogle()
                .sink { completion in
                    // TODO: - 실패 케이스 작업
                } receiveValue: { [weak self] user in
                    self?.userID = user.id
                }.store(in: &subscriptions)
        }
    }
}
