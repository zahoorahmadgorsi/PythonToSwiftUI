//
//  WebService.swift
//  PythonToSwiftUI
//
//  Created by Zahoor Gorsi on 05/03/2024.
//

import Foundation


enum NetworkError: Error {
    case badUrl
    case invalidRequest
    case badResponse
    case badStatus
    case failedToDecodeResponse
}

class WebService {
    let timeoutInterval:TimeInterval = 150  //API call will wait for this much time till it times out
    //let serverURL = "https://services-emilyrewards.envisionmobile.com:3477/"
//    func downloadData<T: Codable>(fromURL: String) async -> T? {
//        do {
//            guard let url = URL(string: fromURL) else { throw NetworkError.badUrl }
//            let (data, response) = try await URLSession.shared.data(from: url)
//            guard let response = response as? HTTPURLResponse else { throw NetworkError.badResponse }
//            guard response.statusCode >= 200 && response.statusCode < 300 else { throw NetworkError.badStatus }
//            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else { throw NetworkError.failedToDecodeResponse }
//            
//            return decodedResponse
//        } catch NetworkError.badUrl {
//            print("There was an error creating the URL")
//        } catch NetworkError.badResponse {
//            print("Did not get a valid response")
//        } catch NetworkError.badStatus {
//            print("Did not get a 2xx status code from the response")
//        } catch NetworkError.failedToDecodeResponse {
//            print("Failed to decode response into the given type")
//        } catch {
//            print("An error occured downloading the data")
//        }
//        
//        return nil
//    }
    
    func postAnimateDiffModel(animateDiffRequest: AnimateDiffRequest, endPoint: String, completion: @escaping (AnimateDiffResponse?, Error?) -> Void) {
        do {
            guard let url = URL(string: self.serverURL + endPoint) else { throw NetworkError.badUrl }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any] = [
                "prompt": animateDiffRequest.prompt ?? "",
                "n_prompt": animateDiffRequest.n_prompt ?? ""
            ]
            let requestBody =  try JSONSerialization.data(withJSONObject: body, options: [])
            request.timeoutInterval = self.timeoutInterval
            request.httpBody = requestBody
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    completion(nil, nil)
                    return
                }
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode == 200 {
                    guard let result = try? JSONDecoder().decode(AnimateDiffResponse.self,from: data)
                    else {
                        completion(nil, NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "No data"]))
                        return
                    }
                    completion(result, nil)
                    return
                } else {
                    print("FAILURE")
                    completion(nil, nil)
                }
            }
                    
            task.resume()
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
    }
    
    func postInstructPix2PixModel(instructPix2PixRequest: InstructPix2PixRequest
                                  ,endPoint: String, completion: @escaping (InstructPix2PixResponse?, Error?) -> Void) {
        do {
            guard let url = URL(string: self.serverURL + endPoint) else { throw NetworkError.badUrl }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            let body: [String: Any] = [
                "image" : instructPix2PixRequest.imageType + instructPix2PixRequest.image,
                "prompt": instructPix2PixRequest.prompt ?? "",
                "n_prompt": instructPix2PixRequest.n_prompt ?? ""
            ]
            let requestBody =  try JSONSerialization.data(withJSONObject: body, options: [])
            request.timeoutInterval = self.timeoutInterval
            request.httpBody = requestBody
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    completion(nil, error)
                    return
                }
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode == 200 {
                    guard let result = try? JSONDecoder().decode(InstructPix2PixResponse.self,from: data)
                    else {
                        completion(nil, NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "No data"]))
                        return
                    }
                    completion(result, nil)
                    return
                } else {
                    print("FAILURE")
                    completion(nil, nil)
                }
            }
            task.resume()
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
    }
    
    func postT2iAdapterSdxlSketch(t2iAdapterSdxlSketchRequest:T2iAdapterSdxlSketchRequest
                                  , endPoint: String, completion: @escaping (T2iAdapterSdxlSketchResponse?, Error?) -> Void) {
        do {
            guard let url = URL(string: self.serverURL + endPoint) else { throw NetworkError.badUrl }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let body: [String: Any] = [
                "image" : t2iAdapterSdxlSketchRequest.imageType + t2iAdapterSdxlSketchRequest.image,
                "prompt": t2iAdapterSdxlSketchRequest.prompt ?? "",
                "n_prompt": t2iAdapterSdxlSketchRequest.n_prompt ?? ""
            ]
            let requestBody =  try JSONSerialization.data(withJSONObject: body, options: [])
            request.timeoutInterval = self.timeoutInterval
            request.httpBody = requestBody
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    completion(nil, nil)
                    return
                }
                
                let statusCode = (response as! HTTPURLResponse).statusCode
                if statusCode == 200 {
                    guard let result = try? JSONDecoder().decode(T2iAdapterSdxlSketchResponse.self,from: data)
                    else {
                        completion(nil, NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "No data"]))
                        return
                    }
                    completion(result, nil)
                    return
                } else {
                    print("FAILURE")
                    completion(nil, nil)
                }
            }
            task.resume()
        } catch NetworkError.badUrl {
            print("There was an error creating the URL")
        } catch NetworkError.badResponse {
            print("Did not get a valid response")
        } catch NetworkError.badStatus {
            print("Did not get a 2xx status code from the response")
        } catch NetworkError.failedToDecodeResponse {
            print("Failed to decode response into the given type")
        } catch {
            print("An error occured downloading the data")
        }
    }
}
