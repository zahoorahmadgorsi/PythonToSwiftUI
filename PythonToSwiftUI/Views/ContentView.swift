//
//  ContentView.swift
//  PythonToSwiftUI
//
//  Created by Zahoor Gorsi on 04/03/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Try out these models")
                    .font(.title)
                
                NavigationLink(destination: InstructPix2PixView(title: "InstructPix2PixView")) {
                    Text("instruct-pix2pix")
                }
                .padding()
                
                
                NavigationLink(destination: T2iAdapterSdxlSketchView(title: "T2iAdapterSdxlSketchView")) {
                    Text("t2i-adapter-sdxl-sketch")
                }
                .padding()
                
                NavigationLink(destination: AnimateDiffView(title: "AnimateDiffView")) {
                    Text("animate-diff")
                }
                .padding()
                
//                NavigationLink(destination: StableDiffusionView(title: "StableDiffusionView")) {
//                    Text("stable-diffusion")
//                }
//                .padding()
            }.listStyle(.insetGrouped)
            .navigationBarTitle("Gary Makinson", displayMode: .inline)
        }
    }
}



#Preview {
    ContentView()
}
