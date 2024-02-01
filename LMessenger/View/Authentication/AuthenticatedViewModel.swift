//
//  AuthenticatedViewModel.swift
//  LMessenger
//
//  Created by 김민준 on 2/1/24.
//

import Foundation
import Combine
import AuthenticationServices

enum AuthenticationState {
    case unAuthenticated
    case authenticated
}

class AuthenticatedViewModel: ObservableObject {
    
    enum Action {
        case checkAuthenticationState
        case googleLogin
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
        case logout
    }
    
    @Published var authenticationState: AuthenticationState = .unAuthenticated
    @Published var isLoading = false
    
    var userID: String?
    
    private var currentNonce: String?
    
    private var container: DIContainer
    
    /// 여기 모든 구독권들이 추가되어 관리 할 수 있게 됨!
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
            
            // 인증 확인
        case .checkAuthenticationState:
            if let userID = container.services.authService.checkAuthenticationState() {
                self.userID = userID
                self.authenticationState = .authenticated
            }
            
            // 구글 로그인
        case .googleLogin:
            isLoading = true
            container.services.authService.signInWithGoogle()
                .sink { [weak self] completion in
                    if case .failure = completion {
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] user in
                    self?.isLoading = false
                    self?.userID = user.id
                    self?.authenticationState = .authenticated
                }.store(in: &subscriptions)
            
            // 애플 로그인
        case let .appleLogin(request):
            let nonce = container.services.authService.handleSignInWithAppleRequest(request)
            self.currentNonce = nonce
            
            // 애플 로그인 완료
        case let .appleLoginCompletion(result):
            if case let .success(authorization) = result {
                guard let nonce = currentNonce else { return }
                container.services.authService.handleSignInWithAppleCompletion(authorization, none: nonce)
                    .sink { [weak self] completion in
                        if case .failure = completion {
                            self?.isLoading = false
                        }
                    } receiveValue: { [weak self] user in
                        self?.isLoading = false
                        self?.userID = user.id
                        self?.authenticationState = .authenticated
                    }.store(in: &subscriptions)
            } else if case let .failure(error) = result {
                isLoading = false
                print(error.localizedDescription)
            }
            
        case .logout:
            container.services.authService.logout()
                .sink { completon in
                    
                } receiveValue: { [weak self] _ in
                    self?.authenticationState = .unAuthenticated
                    self?.userID = nil
                }.store(in: &subscriptions)
        }
    }
}
