//
//  PLUManager.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 1/5/22.
//

import Foundation


enum APIErr: Error{
    case requestFailed
    case responseFailed
    case jsonDecodingFailed
    case invalidURL
    case invalidImageURL
}


struct PluListManager{
    
//Get all PLU code list
func getPluList<T:Codable>(url: URL?, expecting: T.Type, completion:  @escaping(Result<T,APIErr>) -> Void){
        
        //URL STRING ERROR!
    guard let url = url else{
        completion(.failure(.invalidURL))
        return
    }
    
    //Start Data Task
    let dataTask = URLSession.shared.dataTask(with: url){(data, response, error) in

        //SERVER ERROR!
        if let error = error {
            print("From: PLU list Manager Erorr: requestFailed \(error)")
            completion(.failure(.requestFailed))
            return
        }
        
        
        //RESPONSE ERROR!
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
            print("From: PLU list Manager Erorr: responseFailed")
            completion(.failure(.responseFailed))
            return
        }
        
    //JSON DECODE ERROR!
        if let safeData = data{
            
            
            let decoder = JSONDecoder()
            
            do{
                //DECODE JSON DATA
                let decodedData = try decoder.decode(expecting, from: safeData)
                
                completion(.success(decodedData))
            }catch{
                completion(.failure(.jsonDecodingFailed))
                return
            }
        }
    }
    dataTask.resume()
    }
}
