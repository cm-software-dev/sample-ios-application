//
//  AppError.swift
//  ItunesSummary
//
//  Created by Calum Maclellan on 07/05/2025.
//

enum AppError: Error {
    case test(description: String)
    case network(description: String)
    case parsing(description: String)
}
