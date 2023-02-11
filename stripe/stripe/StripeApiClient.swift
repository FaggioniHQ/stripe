//
//  StripeApiClient.swift
//  stripe
//
//  Created by HQ on 10/2/23.
//

import Foundation


import StripeTerminal

// Example API client class for communicating with your backend
class StripeApiClient : ConnectionTokenProvider {

    // For simplicity, this example class is a singleton
    static let shared = StripeApiClient()
    static let url = "https://api-america-3.caagcrm.com/api-america-3/payment-gateways/stripe-locations/3/connection-token"

    // Fetches a ConnectionToken from your backend
    func fetchConnectionToken(_ completion: @escaping ConnectionTokenCompletionBlock) {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Authorization" : "Basic ZGpLVlpuM0NiNmRxb0JSaHpLS015RzZzY0dXeHRjQTlxU2NyYkYzQ2xhVVh4SHlFOXQ6WG5Gd2FBRWNYMHVhclBCSFRIMVJHTVBKc2x6NnhVYWxGMnBZOWY4RGVSY2Y1cko0YVE="
        ]
        let session = URLSession(configuration: config)
        guard let url = URL(string: StripeApiClient.url) else {
            fatalError("Invalid backend URL")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(TokenResponse.self, from: data)
                    completion(data.data.connection_token.secret, nil)
                }
                catch {
                    completion(nil, error)
                }
            }
            else {
                let error = NSError(domain: "com.stripe-terminal-ios.example",
                                    code: 1000,
                                    userInfo: [NSLocalizedDescriptionKey: "No data in response from ConnectionToken endpoint"])
                completion(nil, error)
            }
        }
        task.resume()
    }
}
