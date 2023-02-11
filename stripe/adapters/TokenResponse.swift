//
//  TokenResponse.swift
//  stripe
//
//  Created by HQ on 11/2/23.
//

import Foundation

struct TokenResponse : Codable{
    let success : Bool
    let status_code : Int
    let data : TokenResponseData
}
