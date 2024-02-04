//
//  DBError.swift
//  LMessenger
//
//  Created by 김민준 on 2/4/24.
//

import Foundation

enum DBError: Error {
    case error(Error)
    case emptyValue
    case invaildatedType
}
