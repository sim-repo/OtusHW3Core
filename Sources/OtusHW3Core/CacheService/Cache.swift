//
//  Cache.swift
//  IvanovIgorHW2
//
//  Created by Igor on 11.01.2023.
//


import Foundation


public final class CacheService<Entity>{
    private(set) var entities: [Entity] = []

    public init(){}
    
    var hasData: Bool {
        return !entities.isEmpty
    }
    
    public func append(entities: [Entity]?){
        guard let arr = entities else { return }
        self.entities.append(contentsOf: arr)
    }
}

