//
//  Extension+URLSessionError.swift
//  Pokedex
//
//  Created by Consultant on 6/17/22.
//

import Foundation

extension URLSession {
    enum RequestErrors: Error {
        case badURL
        case badData
    }
}
