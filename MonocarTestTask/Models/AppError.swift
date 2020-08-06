//
//  AppError.swift
//  MonocarTestTask
//
//  Created by User on 05.08.2020.
//  Copyright © 2020 ValeriiaTarasenko. All rights reserved.
//

import Foundation

enum AppError: Error {
    case unknown, failed, custom(String)
    
    var localizedDescription: String {
        switch self {
        case .unknown: return "Unknown error!"
        case .failed: return "Error!"
        case .custom(let text): return text
        }
    }
}
