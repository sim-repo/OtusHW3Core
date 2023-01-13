//
//  ServiceLocator.swift
//  IvanovIgorHW2
//
//  Created by Igor on 10.01.2023.
//


import Foundation
import NetworkModule


// DI: закрываем протоколом
protocol ServiceLocatorProtocol {
    func getService<T>() -> T?
}


final class ServiceLocator: ServiceLocatorProtocol {
    
    private init(){}
    
    public static let shared = ServiceLocator()
    
    private lazy var services: [String:Any] = [:]
    
    private func typeName(some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))'"
    }
    
    func addService<T>(service: T) {
        let key = typeName(some: T.self)
        services[key] = service
    }
    
    func getService<T>() -> T? {
        let key = typeName(some: T.self)
        return services[key] as? T
    }
}


