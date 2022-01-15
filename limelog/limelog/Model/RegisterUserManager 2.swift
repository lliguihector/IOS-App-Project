//
//  RegisterNewUserManager.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/24/21.
//




import Foundation

//Enumerators for function error throws
enum NetworkError: Error{
    case requestFailed
    case responseFailed
    case jsonDecodingFailed
    case jsonEncodingFailed
}

//Protocal methods to be called on Register View controller
protocol RegisterUserManagerDelegate{
    func didFailWithError(error: Error)
    func responseError(responseError: String)
}





struct RegisterUserManager {
    
    //url constsnt string decleration
    let resourceURL =  constant.registerNewUser
    
    
    //delegate tasks to other classes outside of this class
    var delegate: RegisterUserManagerDelegate?
    
    //*NOTE*: Need to refactor code transition to apples new async await asyncronous/concoruncy framework
    
    
    //asynchronous completion handler methoth returns user upon success or api call errors
    func createUser(_ newUserToSave: NewUserData, completion: @escaping(Result<UserData,NetworkError>)-> Void){
        
        do{
            //Crate the url request
            var urlRequest = URLRequest(url:resourceURL!)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-Type")
            urlRequest.addValue("application", forHTTPHeaderField: "Acept")
            
            //Convert model to JSON data
            urlRequest.httpBody = try JSONEncoder().encode(newUserToSave)
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest){(data, response,error) in
                
                //CANT CONNECT TO THE SERVER
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    completion(.failure(.requestFailed))
                    return
                }
                //If We get a 400 Error
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                  
                    if let rData = data {
                        let dataString = String(data:  rData, encoding: .utf8)
                        print(dataString!)
                        self.delegate?.responseError(responseError: dataString!)
                    }
                    
                    completion(.failure(.responseFailed))
                    return
                }
                //Decode response body JSON api messeges to the client
                if let safeData = data{
                    do{
                        let newUser = try JSONDecoder().decode(UserData.self, from: safeData)
                        completion(.success(newUser))
                        print(newUser._id)
                    }catch{
                        self.delegate?.didFailWithError(error: error)
                        completion(.failure(.jsonDecodingFailed))
                        return
                    }
                }
            }
            
            dataTask.resume()
        }catch{
            self.delegate?.didFailWithError(error: error)
            completion(.failure(.jsonEncodingFailed))
        }
    }

}
