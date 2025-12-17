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
    var isExpensive: Bool = false
    
    private init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.isExpensive = path.isExpensive
        }
        monitor.start(queue: queue)
    }
}

