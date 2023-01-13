//
//  FetchService.swift
//  IvanovIgorHW2
//
//  Created by Igor on 11.01.2023.
//

import Foundation

//DIP: сервисы закрываем протоколом
public protocol FetchDataProtocol {
    // приоритет получения данны из кэша:
    func loadData<T:EntityProtocol>(_ type: EntityEnum, with completionHandler: @escaping ([T]) -> Void )
    // подгрузка данных с сервера
    func fetchData<T:EntityProtocol>(_ type: EntityEnum, with completionHandler: @escaping ([T]) -> Void )
}



//Сервис подкачки данных
class FetchDataService: FetchDataProtocol {
    
    private let serviceLocator: ServiceLocatorProtocol
    
    private var nextPage = 1
    
    init(serviceLocator: ServiceLocatorProtocol){
        self.serviceLocator = serviceLocator
    }
    
    func loadData<T:EntityProtocol>(_ type: EntityEnum, with completionHandler: @escaping ([T]) -> Void) {
        guard let cache:CacheService<T> = getCache() else { return }
        
        //store:
        if cache.hasData {
            completionHandler(cache.entities)
            return
        }
        
        //network:
        runNetworkRequest(cache, completionHandler)
    }
    
    
    func fetchData<T:EntityProtocol>(_ type: EntityEnum, with completionHandler: @escaping ([T]) -> Void) {
        guard let cache:CacheService<T> = getCache() else { return }
        runNetworkRequest(cache, completionHandler)
    }
    
    
    private func getCache<T:EntityProtocol>() -> CacheService<T>? {
        guard let cache: CacheService<T> = serviceLocator.getService()
        else {
            debugPrint("service locator does not contain such a service")
            return nil
        }
        return cache
    }
    
    
    private func runNetworkRequest<T:EntityProtocol>(_ cache: CacheService<T>, _ completionHandler: @escaping ([T]) -> Void){
        //network:
        SomeNetworkRequest().request(nextPage){ [weak self] entities in
            self?.nextPage += 1
            cache.append(entities: entities)
            completionHandler(entities)
        }
    }
}
