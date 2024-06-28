//
//  T2iAdapterSdxlSketch.swift
//  PythonToSwiftUI
//
//  Created by Zahoor Gorsi on 05/03/2024.
//

import Foundation

//Codable is wrapper around a set of protocols in Swift that will allow us to decode JSON into our Post model type, and also encode our Post model type back into JSON (should we need to make a post request to the endpoint).
struct AnimateDiffResponse: Codable {
    let output: URL?
}

struct AnimateDiffRequest:Codable{
    let prompt: String?
    let n_prompt: String?
}
