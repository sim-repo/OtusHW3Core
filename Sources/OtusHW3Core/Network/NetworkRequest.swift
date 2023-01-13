//
//  NetworkService.swift
//  IvanovIgorHW2
//
//  Created by Igor on 11.01.2023.
//

import Foundation

enum EntityEnum {
    case news,rickAndMorty
}


struct SomeNetworkRequest<T: EntityProtocol> {
    
    func request(_ currentPage: Int, with completionHandler: @escaping ([T]) -> Void){
        
        if T.self is Article.Type {
            ArticlesAPI.everythingGet(q: "apple",
                                      from: "2023-01-11",
                                      sortBy: "publishedAt",
                                      apiKey: "dae53cecec8342ac8fcf172a69ef8867",
                                      language: "en",
                                      pageSize: 10,
                                      page: currentPage ){ data, error in
                guard error == nil
                else {
                    debugPrint(error!)
                    return
                }
                completionHandler((data?.articles as? [T]) ?? [])
            }
            return
        }
        
        
        
        if T.self is ModelCharacter.Type {
            CharactersAPI.getAllCharacters(page: currentPage, apiResponseQueue: DispatchQueue.global()) { data, error in
                
                guard error == nil
                else {
                    debugPrint(error!)
                    return
                }
                completionHandler((data?.results as? [T]) ?? [])
            }
        }
    }
}




protocol NetworkRequestProtocol {
    associatedtype Entity: EntityProtocol
    
    func request(_ currentPage: Int, with completionHandler: @escaping ([Entity]) -> Void)
}



struct ArticleNetworkRequest: NetworkRequestProtocol {

    func request(_ currentPage: Int, with completionHandler: @escaping ([Article]) -> Void){
        ArticlesAPI.everythingGet(q: "apple",
                                  from: "2023-01-11",
                                  sortBy: "publishedAt",
                                  apiKey: "dae53cecec8342ac8fcf172a69ef8867",
                                  language: "en",
                                  pageSize: 10,
                                  page: currentPage ){ data, error in
            guard error == nil
            else {
                debugPrint(error!)
                return
            }
            completionHandler(data?.articles ?? [])
        }
    }
}



struct CharacterNetworkRequest: NetworkRequestProtocol {

    func request(_ currentPage: Int, with completionHandler: @escaping ([ModelCharacter]) -> Void){
        
        CharactersAPI.getAllCharacters(page: currentPage, apiResponseQueue: DispatchQueue.global()) { data, error in
            
            guard error == nil
            else {
                debugPrint(error!)
                return
            }
            completionHandler(data?.results ?? [])
        }
    }
}
