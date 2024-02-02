//
//  HomeViewModel.swift
//  LMessenger
//
//  Created by 김민준 on 2/2/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var myUser: User?
    @Published var users: [User] = [.stub1, .stub2]
}
