//
//  StableDiffusionView.swift
//  PythonToSwiftUI
//
//  Created by Zahoor Gorsi on 04/03/2024.
//

import SwiftUI
import PhotosUI
import AVKit

//https://replicate.com/docs/get-started/swiftui
// https://replicate.com/stability-ai/stable-diffusion
struct StableDiffusionView: View {
    
    var title: String
    //@State private var prompt = "an astronaut riding a horse on mars, hd, dramatic lighting"
    @State private var prompt = ""
    @State private var negativePrompt = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var body: some View {
        Form {
            Section {
                TextField(text: $prompt,
                          prompt: Text("Enter a prompt to display an image"),
                          label: {})
                .submitLabel(.go)
                .onSubmit(of: .text) {
                    Task {
//                        try await generate()
                    }
                }
            }
            Section {
                TextField(text: $negativePrompt,
                          prompt: Text("Negative prompt (things to not see in the output)"),
                          label: {})
                .submitLabel(.go)
                .onSubmit(of: .text) {
                    Task {
//                        try await generate()
                    }
                }
            }
        }.navigationBarTitle(title, displayMode: .inline)
    }
}

#Preview {
    StableDiffusionView(title: "StableDiffusion")
}
