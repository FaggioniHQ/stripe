//
//  ConnectionToken.swift
//  stripe
//
//  Created by HQ on 11/2/23.
//

import Foundation

struct ConnectionToken : Codable {
    let object : String
    let location : String
    let secret : String
}
