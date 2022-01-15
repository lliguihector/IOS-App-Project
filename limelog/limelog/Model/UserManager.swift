//
//  Manager.swift
//  limelog
//
//  Created by Hector Lliguichuzca on 5/11/21.
//

import Foundation

enum APICallError: Error{
    case requestFailed
    case responseFailed
    case jsonDecodingFailed
    case invalidUrl
}

//Protocol methods to be called outside of this class/structure
protocol UserManagerDelegate {
    func didUpdateUser(_ userManager: UserManager, user: UserModel)
    func didFailWithError(error: Error)
    func finishDispatch()
}




struct UserManager{
    
    //Create a dispatch group
    let urls = [
       "http://localhost:3000/user/",
        "http://localhost:3000/info/60e75b06160bd53c281f3e26",
    ]
    func fetchResources(){
        let group = DispatchGroup()
        
        for url in urls{
            
            guard let url = URL(string: url)else{
                continue
            }
            
            
            group.enter()
            let task = URLSession.shared.dataTask(with: url, completionHandler: {data, rsponse , error in
                
                defer{
                    group.leave()
                }
                
                if let safeData = data{
                    let dataString = String(data: safeData, encoding: .utf8)
                    
                    print(dataString!)
                }
                
            })
            task.resume()
                
            }
        group.notify(queue: .main, execute:{
            //Update user interface
            print("Done with all operations")
            self.delegate?.finishDispatch()
            
        })
        }
        
        
    
    
    
    
    let apiURL = "http://localhost:3000/user/"
    let infoURL = "http://localhost:3000/info/"

    var delegate: UserManagerDelegate?
    
//    var users = [UserData]()
    
    
    //Set the url user id endpoint
//    func fetchUserID(userId: String){
//        let urlString = "\(apiURL)\(userId)"
//        performRequest(with: urlString)
//    }
    
    
    //Get All Users from Database
    func getAllUsers<T: Codable>(url: URL?, expecting: T.Type, completion: @escaping(Result<T,APICallError>) -> Void){
        
        
        guard let url = url else{
            completion(.failure(.invalidUrl))
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url){(data, response, error) in
            
            //Server error
            if let error = error{
                
                print(error)
                completion(.failure(.requestFailed))
                return
            }
            
            //Response Error
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
              
                completion(.failure(.responseFailed))
                return
            }
            
            
            //JSON Decode Error
            if let safeData = data{
                
                let decoder = JSONDecoder()
                do{
                    //Decode JSON data
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
    
    
    
    func getUserByID(_ userID: String,_ token: String , completion: @escaping(Result<UserModel,APICallError>) -> Void){
        if let url = URL(string: "\(apiURL)\(userID)"){

            
            
            //Set Header token
            var request = URLRequest(url:url)
            request.addValue(token, forHTTPHeaderField: "auth-token")
            
            
            let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
                
                
                //Server connection Error
                if error != nil{
                    
                    completion(.failure(.requestFailed))
                    
                    return
                }
                //Response Error
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    //Response body message
                    if let rData = data{
                        let dataString = String(data: rData, encoding: .utf8)
                        print(dataString!)
                    }
                    
                    completion(.failure(.responseFailed))
                    
                    return
                }
                
                //JSON Decoding error
                if let safeData = data{
                    
                    if let userData = self.parseJSON(safeData){
                        completion(.success(userData))
                        delegate?.didUpdateUser(self, user:userData)
                    }else{
                        completion(.failure(.jsonDecodingFailed))
                        
                        return
                    }
                    
                }

            }
            dataTask.resume()
        }else{
            completion(.failure(.invalidUrl))
            
            return
        }
 
        
    }
    
    
    //GET USER PERSONAL INfo
    func fetchUsersInfo(_ userID: String, completion: @escaping(Result<PersonalInfoModel,APICallError>) -> Void){
    
    
        if let url = URL(string: "\(infoURL)\(userID)"){
            
            let dataTask = URLSession.shared.dataTask(with: url){(data, response, error)in
                //SERVER ERROR!
                if error != nil{
                    completion(.failure(.requestFailed))
                    return
                }
                
                //RESPONSE ERROR
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    //RESPONSE 400 ERROR MESSAGE
                    
                    if let responseData = data{
                        let dataString = String(data: responseData, encoding: .utf8)
                        print(dataString!)
                    }
                    completion(.failure(.responseFailed))
                    return
                }
                
                //JSON DECODING 
                if let safeData = data {
                    
                    if let userInfo = self.parseUserInfoData(safeData){
                        completion(.success(userInfo))
                    }else{
                        completion(.failure(.jsonDecodingFailed))
                        return
                    }
                }
            }
            dataTask.resume()
        }else{
  
            completion(.failure(.invalidUrl))
            return
        }
    }
    
    //Update userPersonalINfo
    func updateUserInfo(){
        
         
    }
    
    
    
    
    //*NOTE*: Need to make the method asyncronous
//    func performRequest(with urlString: String){
//        //1.Create a URL
//        if let url = URL(string: urlString){
//
//            //2. Create a URLSession
//            let session = URLSession(configuration: .default)
//
//
//            //3.Give the session a task
//            let task = session.dataTask(with: url) { (data, response, error) in
//                //If there was an error connecting to the server
//                if error != nil{
//
//                    self.delegate?.didFailWithError(error: error!)
//
//                    //if there is an error just return
//                    return
//                }
//
//            print(response!)
//                //If API Response with json data decode set data
//                if let safeData = data{
//                    //old code refrence -> let dataString = String(data: safeData, encoding: .utf8)
//
//                    if let user = self.parseJSON(safeData){
//                        delegate?.didUpdateUser(self, user:user)
//                    }
//                    //old code refrence -> print(dataString)
//                }
//            }
//            //4. Start the task
//            task.resume()
//        }
//
//
//    }
    
    //Decode JSON API Response custom method that returns a User Model Object
    func parseJSON(_ apiData: Data)-> UserModel? {
        let decoder = JSONDecoder()
        do{
            //Decode JSON data
            let decodedData = try decoder.decode(UserData.self, from: apiData)
    
            let id = decodedData._id
            let name = decodedData.name
            let email = decodedData.email
            let password = decodedData.password
            let date = decodedData.date
            
            //Create a new User Model Object
            let user = UserModel(userId: id, name: name, email: email, password: password, date: date)
            
            //return the user
            return user
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    func parseUserInfoData(_ apiData: Data)-> PersonalInfoModel?{
        
        
        let decoder = JSONDecoder()
        
        
        do{
            let decodeData = try decoder.decode(PersonalInfoData.self, from: apiData)
            
            
//            let id = decodeData._id
            let firstName = decodeData.firstname
            let lastName = decodeData.lastname
            let refrenceID = decodeData.user_id
            
            let userPersonalInfo = PersonalInfoModel(firstName: firstName, lastName: lastName, userIdRef: refrenceID)
            
            return userPersonalInfo
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}




