//
//  NetworkMonitor.swift
//  medoraApp
//
//  Created by Nazrin Asgarova on 10.12.25.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    var isConnected: Bool = false
    var isExpensive: Bool = false // WiFi yoxsa Mobile Data
    
    private init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.isExpensive = path.isExpensive
            
            // UI-ı yeniləmək üçün Main thread-ə keç
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    print("Internet var")
                    // Burada internet varsa nəsə et
                } else {
                    print("Internet yoxdur")
                    // Burada internet yoxdursa xəbərdarlıq göstər və s.
                 //   self?.showNoInternetAlert()
                }
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}

