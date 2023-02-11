import UIKit
import StripeTerminal
import CoreLocation

class ViewController: UIViewController, DiscoveryDelegate, BluetoothReaderDelegate, CLLocationManagerDelegate {
    
    let readerMessageLabel = UILabel(frame: .zero)
    var collectCancelable: Cancelable? = nil
    
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
        self.discoverReadersAction()
        // Do any additional setup after loading the view.
    }
    
    
    func discoverReadersAction() {
        let config = DiscoveryConfiguration(
            discoveryMethod : .localMobile,
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
                self.checkoutAction()
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
    
    func checkoutAction() {
            let params = PaymentIntentParameters(amount: 10000, currency: "usd")
            Terminal.shared.createPaymentIntent(params) { createResult, createError in
                if let error = createError {
                    print("createPaymentIntent failed: \(error)")
                } else if let paymentIntent = createResult {
                    print("createPaymentIntent succeeded")
                    self.collectCancelable = Terminal.shared.collectPaymentMethod(paymentIntent) { collectResult, collectError in
                    if let error = collectError {
                        print("collectPaymentMethod failed: \(error)")
                    }
                    else if let paymentIntent = collectResult {
                        print("collectPaymentMethod succeeded")
                        // ... Process the payment
                        Terminal.shared.processPayment(paymentIntent) { processResult, processError in
                          if let error = processError {
                              print("processPayment failed: \(error)")
                          } else if let processPaymentPaymentIntent = processResult {
                              print("processPayment succeeded")
                              // Notify your backend to capture the PaymentIntent
                              //manual
                          }
                      }
                    }
                }
                    // ...
                }

            }
        }



}

