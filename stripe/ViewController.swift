//
//  ViewController.swift
//  stripe
//
//  Created by HQ on 10/2/23.
//

import UIKit
import StripeTerminal

class ViewController: UIViewController, DiscoveryDelegate {
    
    var discoverCancelable: Cancelable?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func discoverReadersAction() {
        let config = DiscoveryConfiguration(
            discoveryMethod: ,
          simulated: false
        )

        self.discoverCancelable = Terminal.shared.discoverReaders(config, delegate: self) { error in
            if let error = error {
                print("discoverReaders failed: \(error)")
            } else {
                print("discoverReaders succeeded")
            }
        }
    }
    func terminal(_ terminal: Terminal, didUpdateDiscoveredReaders readers: [Reader]) {
        // In your app, display the ability to use your phone as a reader
        // Call `connectLocalMobileReader` to initiate a session with the phone
        let connectionConfig = LocalMobileConnectionConfiguration(locationId:"tml_E7vm6QF50AUs4Y")
        Terminal.shared.connectLocalMobileReader(selectedReader, delegate: readerDelegate, connectionConfig: connectionConfig) { reader, error in
            if let reader = reader {
                print("Successfully connected to reader: \(reader)")
            } else if let error = error {
                print("connectLocalMobileReader failed: \(error)")
            }
    }


}

