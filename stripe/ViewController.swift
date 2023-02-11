//
//  ViewController.swift
//  stripe
//
//  Created by HQ on 10/2/23.
//

import UIKit
import StripeTerminal
import CoreLocation

class ViewController: UIViewController, DiscoveryDelegate, BluetoothReaderDelegate, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    func reader(_ reader: Reader, didReportAvailableUpdate update: ReaderSoftwareUpdate) {
        
    }
    
    func reader(_ reader: Reader, didStartInstallingUpdate update: ReaderSoftwareUpdate, cancelable: Cancelable?) {
        
    }
    
    func reader(_ reader: Reader, didReportReaderSoftwareUpdateProgress progress: Float) {
        
    }
    
    func reader(_ reader: Reader, didFinishInstallingUpdate update: ReaderSoftwareUpdate?, error: Error?) {
        
    }
    
    func reader(_ reader: Reader, didRequestReaderInput inputOptions: ReaderInputOptions = []) {
        
    }
    
    func reader(_ reader: Reader, didRequestReaderDisplayMessage displayMessage: ReaderDisplayMessage) {
        
    }
    
    
    var discoverCancelable: Cancelable?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        print("view-0")
        self.discoverReadersAction()
        // Do any additional setup after loading the view.
    }
    
    
    func discoverReadersAction() {
        let config = DiscoveryConfiguration(
          discoveryMethod: .bluetoothScan,
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
        print("termina;")
        // In your app, display the ability to use your phone as a reader
        // Call `connectLocalMobileReader` to initiate a session with the phone
        let connectionConfig = BluetoothConnectionConfiguration(locationId: "tml_E7vm6QF50AUs4Y")
        Terminal.shared.connectBluetoothReader(
            readers[0],
            delegate: self,
            connectionConfig: connectionConfig) { reader, error in
            if let reader = reader {
                print("Successfully connected to reader: \(reader)")
            } else if let error = error {
                print("connectBluetoothReader failed: \(error)")
            }
        }
        /*
        let connectionConfig = LocalMobileConnectionConfiguration(locationId:"tml_E7vm6QF50AUs4Y")
        Terminal.shared.connectLocalMobileReader(selectedReader, delegate: readerDelegate, connectionConfig: connectionConfig) { reader, error in
            if let reader = reader {
                print("Successfully connected to reader: \(reader)")
            } else if let error = error {
                print("connectLocalMobileReader failed: \(error)")
            }*/
    }


}

