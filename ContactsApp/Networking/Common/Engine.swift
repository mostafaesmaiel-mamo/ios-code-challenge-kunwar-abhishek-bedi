//
//  Engine.swift
//  ContactsApp
//
//  Created by kbedi on 12/06/2021.
//

import Foundation

struct NetworkEngine: Fetchable {
    
    func fetch(_ dataRequest: URLRequest, completion: @escaping NetworkCompletion) {
        
        manager.dataTask(with: dataRequest) { data, response, error in
            completion(data, response as? HTTPURLResponse, error)
        }.resume()
    }
    
    fileprivate let manager: URLSession

    init(manager: URLSession = URLSession.shared) {
        self.manager = manager
    }
    
    func request<T: Resultable>(buildable: Buildable, type: T.Type, completion: @escaping (ServiceResult<T>) -> Void) {
        
        do {
            let request = try buildable.asURLRequest()
            print(request.cURL)
            fetch(request, completion: completion)
        } catch let exception {
            completion(.failure(ServiceError(error: exception.localizedDescription)))
        }
    }
}

fileprivate extension NetworkEngine {
    
    func fetch<T: Resultable>(_ request: URLRequest, completion: @escaping (ServiceResult<T>) -> Void) {

        fetch(request) { (data, response, error) in
            guard let responseData = data, response != nil else {
                completion(.failure(ServiceError(error: NetworkError.noData.value)))
                return
            }
            
            completion(T.result(responseData: responseData, response: response))
        }
    }
}
