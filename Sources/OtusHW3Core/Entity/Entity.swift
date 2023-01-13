//
//  Entity.swift
//  IvanovIgorHW2
//
//  Created by Igor on 12.01.2023.
//

import Foundation
import NetworkModule


//Создаем ограничитель для сущностей, используемые для дженериковых методов
protocol EntityProtocol{}

extension Article: EntityProtocol {}

extension ModelCharacter: EntityProtocol {}




//
//struct Sample: EntityProtocol {
//
//}
//
//func go<T:EntityProtocol>(completion: ([T]) -> Void ){
//    var arr: [T] = []
//
//    arr.append((Sample() as! T))
//    completion(arr)
//}
//
//func checkGo(){
//    let c: ([Article]) -> Void = {article in
//
//    }
//    go(completion: c)
//}
