//
//  InternetChecker.swift
//  FinanceBook
//
//  Created by pavel mishanin on 27.06.2022.
//

import Foundation
import Network

protocol IInternetChecker {
    func setInternetStatusListener(completion: ((Bool) -> ())?)
}

final class InternetChecker {
    
    private let pathMonitor = NWPathMonitor()
    
    private var networkAvailableHandler: ((Bool) -> ())? = nil
    
    init() {
        self.getPathStatus()
        pathMonitor.start(queue: DispatchQueue.global(qos: .background))
    }
}

extension InternetChecker: IInternetChecker {
    
    func setInternetStatusListener(completion: ((Bool) -> ())? = nil) {
        networkAvailableHandler = completion
        
        let status = getInternetStatus()
        completion?(status)
    }
}

private extension InternetChecker {
    
    func getPathStatus() {
        pathMonitor.pathUpdateHandler = { path in
            
            let status = path.status == .satisfied
            self.networkAvailableHandler?(!status)
        }
    }
    
    func cancelInternetStatusListener() {
        pathMonitor.cancel()
    }
    
    func getInternetStatus() -> Bool {
        return pathMonitor.currentPath.status == .satisfied
    }
}
