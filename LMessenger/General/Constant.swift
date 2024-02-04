//
//  Constant.swift
//  LMessenger
//
//  Created by 김민준 on 2/4/24.
//

import Foundation

enum Constant { }

typealias DBKey = Constant.DBKey

extension Constant {
    struct DBKey {
        static let Users = "Users"
        static let ChatRooms = "ChatRooms"
        static let Chats = "Chats"
    }
}
