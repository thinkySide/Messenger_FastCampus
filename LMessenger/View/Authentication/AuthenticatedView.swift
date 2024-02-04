//
//  AuthenticatedView.swift
//  LMessenger
//
//

import SwiftUI

struct AuthenticatedView: View {
    
    @StateObject var authViewModel: AuthenticatedViewModel
    
    var body: some View {
        VStack {
            switch authViewModel.authenticationState {
            case .unAuthenticated:
                LoginIntroView()
                    .environmentObject(authViewModel)
            case .authenticated:
                MainTabView()
                    .environmentObject(authViewModel)
            }
        }
        .onAppear {
            authViewModel.send(action: .checkAuthenticationState)
        }
    }
}

#Preview {
    AuthenticatedView(authViewModel: .init(container: .init(services: StubService())))
}
