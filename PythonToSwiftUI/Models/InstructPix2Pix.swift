//
//  T2iAdapterSdxlSketch.swift
//  PythonToSwiftUI
//
//  Created by Zahoor Gorsi on 05/03/2024.
//

import Foundation

//Codable is wrapper around a set of protocols in Swift that will allow us to decode JSON into our Post model type, and also encode our Post model type back into JSON (should we need to make a post request to the endpoint).
struct InstructPix2PixResponse: Codable {
    let output: [URL]?
}


struct InstructPix2PixRequest:Codable{
    let image: String
    var imageType = "data:image/png;base64,"    //have to add this string for replicate to work
//    var imageType = "data:image/jpeg;base64,"
    let prompt: String?
    let n_prompt: String?
}
