//
//  NetworkService.swift
//  LoginApp
//
//  Created by Eugene Mokhan on 23/02/2022.
//

import Foundation

enum NetworkService {
    static func getJSONData(completion: @escaping (Result<[TransactionModel], Error>) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: Constants.url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            guard response != nil else {
                completion(.failure(NetworkError.uknownServerResponse))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.noDataReceived))
                return
            }
            let decoder = JSONDecoder()
            do {
                let decoderData = try decoder.decode([TransactionModel].self, from: data)
                completion(.success(decoderData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
