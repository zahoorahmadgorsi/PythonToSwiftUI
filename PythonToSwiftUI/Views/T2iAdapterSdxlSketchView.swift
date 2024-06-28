//
//  T2iAdapterSdxlSketchView.swift
//  PythonToSwiftUI
//
//  Created by Zahoor Gorsi on 04/03/2024.
//

import SwiftUI
import PhotosUI
import AVKit

//https://replicate.com/alaradirik/t2i-adapter-sdxl-sketch
struct T2iAdapterSdxlSketchView: View {
    
    
    var title: String
//    @State private var prompt = "a robot, mount fuji in the background, highly detailed"
//    @State private var negativePrompt = "extra digit, fewer digits, cropped, worst quality, low quality, glitch, deformed, mutated, ugly, disfigured"
    @State private var prompt = ""
    @State private var negativePrompt = ""
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    @StateObject var vm = T2iAdapterSdxlSketchVM()
    
    var body: some View {
        Form {
            Section{
                PhotosPicker(
                    selection: $selectedItem,
                    // maxSelectionCount: 2, //set max selection from gallery
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Text("Choose Photo from Gallery")
                        .frame(width: 350, height: 50)
                        .background(Capsule().stroke(lineWidth: 2))
                }
                .onChange(of: selectedItem) { oldValue, newValue in
                    Task { // Incase of multiple selection newValue is of array type
                        if let data = try? await newValue?.loadTransferable(type: Data.self) {
                            selectedImageData = data
                        }
                    }
                }
                if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(32)
                        .frame(width: 350, height: 250)
                }
            }
            Section {
                TextField(text: $prompt,
                          prompt: Text("Enter a prompt to display an image"),
                          label: {})
                .submitLabel(.go)
                .onSubmit(of: .text) {
                    Task {
                        await self.callAPI()
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
                        await self.callAPI()
                    }
                }
            }
            if (vm.loading){
                ProgressView("Generatings")
            }
            if let item = vm.items.first, item.output?.count ?? 0 > 0{
                VStack {
                    ForEach(item.output ?? [], id: \.self){ outputURL in
                        AsyncImage(url: outputURL, scale: 2.0, content: { phase in
                            phase.image?
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(32)
                        })
                    }
                }
            }
        }
        .navigationBarTitle(title, displayMode: .inline)
    }
    
    func callAPI() async{
        if let selectedImageData,
           let uiImage = UIImage(data: selectedImageData)?.compressJpeg(.lowest) {
            let t2iAdapterSdxlSketchRequest = T2iAdapterSdxlSketchRequest(image: uiImage.base64EncodedString(options: []), prompt: prompt, n_prompt: negativePrompt)
            await vm.postData(t2iAdapterSdxlSketchRequest: t2iAdapterSdxlSketchRequest)
        }
    }
}


#Preview {
    T2iAdapterSdxlSketchView(title: "T2iAdapterSdxlSketch")
}
