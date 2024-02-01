//
//  AuthenticatedView.swift
//  LMessenger
//
//

import SwiftUI

struct AuthenticatedView: View {
    
    @StateObject var authViewModel: AuthenticatedViewModel
    
    var body: some View {
        switch authViewModel.authenticationState {
        case .unAuthenticated:
            LoginIntroView()
                .environmentObject(authViewModel)
        case .authenticated:
            MainTabView()
        }
    }
}

#Preview {
    AuthenticatedView(authViewModel: .init(container: .init(services: StubService())))
}
