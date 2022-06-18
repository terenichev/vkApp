//
//  AppError.swift
//  vkApp
//
//  Created by Денис Тереничев on 14.06.2022.
//

import Foundation

import Foundation

enum AppError: String, Error {
    case noDataProvided = "noDataProvided"
    case failedToDecode = "failedToDecode"
    case errorTask = "errorTask"
    case notCorrectUrl = "notCorrectUrl"
}
