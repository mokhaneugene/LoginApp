//
//  NetworkError.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 23/02/2022.
//

import Foundation

enum NetworkError: Error {
    case uknownURL
    case uknownServerResponse
    case noDataReceived

    var description: String {
        switch self {
        case .uknownURL:
            return "Invalid URL"
        case .uknownServerResponse:
            return "Checl internet connection"
        case .noDataReceived:
            return "No data was received from the server"
        }
    }
}
