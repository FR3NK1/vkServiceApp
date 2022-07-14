//
//  NetworkService.swift
//  vkServicesApp
//
//  Created by Дмитрий Миронов on 13.07.2022.
//

import Foundation


protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
}

extension URLSession: URLSessionProtocol {}

class NetworkManager {
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    
    static let shared = NetworkManager()
    
    public func getData(completion: @escaping ([Service]?, Error?) -> ()) {
        guard let url = URL(string: "https://publicstorage.hb.bizmrg.com/sirius/result.json") else { return }
       
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completion(nil, NetworkError.emptyData)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(ApiResult.self, from: data)
                DispatchQueue.main.async {
                    completion(json.body.services, nil)
                }
            } catch {
                print(error)
                completion(nil, error)
            }
        }.resume()
    }
}
