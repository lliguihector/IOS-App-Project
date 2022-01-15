//
//  LoginManager.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/18/21.
//

import Foundation


//Enums for custome API error throw
enum APIError: Error{
    case requestFailed
    case responseFailed
    case jsonDecodingFailed
    case jsonEncodingFailed
    case invalidCredentials
}


struct LoginManager {
    
    
    let resourceURL: URL
    
    
    
 //Initialize url string
    init(endpoint: String){
        let resourceString = "http://localhost:3000/\(endpoint)"
        guard let resourceURL = URL(string: resourceString) else{fatalError()}
        self.resourceURL = resourceURL
    }
    

    
    //asynchronous completion handler function returns jwt token or api errors
    func loginUser(_ userToSave:LoginData, completion: @escaping(Result<String,APIError>) -> Void){
        
        do{
            
            var urlRequest = URLRequest(url:resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userToSave)
           
            let dataTask = URLSession.shared.dataTask(with: urlRequest){(data, response, error)  in
                
                //Store JWT TOKEN
              
                
                //SERVER CONNECTION ERROR
                if error != nil{
                    
                    print("API SERVER CONNECT ERROR!:")
                    completion(.failure(.requestFailed))
                    return
                }
                
                
                //BAD REQUEST RESPONCE ERROR
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                    
                    if let rData = data{
                        let dataString = String(data:  rData, encoding: .utf8)
                        print(dataString!)
                    }
                    
                    
                    print("API RESPONSE ERROR!: ")
                    //Invalid Token 
                    completion(.failure(.responseFailed))
                    return
                }
                
                
                //DECODE JSON RESPONSE BODY DATA
                if let jsonData = data{
                do{
                 //JWT 
                    let dataString = String(data: jsonData, encoding: .utf8)
                    print(dataString!)
                    
                    let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: jsonData)
                    
                    guard let token = loginResponse.token else{
                        completion(.failure(.invalidCredentials))
                        return
                    }
                    
                    completion(.success(token))
                    
                }catch{
                    completion(.failure(.jsonDecodingFailed))
                    return
                }
                
            }
            }
            dataTask.resume()
        }
        
        //JSON ENCODING ERROR
        catch{
              completion(.failure(.jsonEncodingFailed))
        }

    }
    
    
    
   
      
}



















