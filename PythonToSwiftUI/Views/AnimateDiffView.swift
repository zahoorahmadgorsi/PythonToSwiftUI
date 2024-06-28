//
//  AnimateDiffView.swift
//  PythonToSwiftUI
//
//  Created by Zahoor Gorsi on 04/03/2024.
//

import SwiftUI
import PhotosUI
import AVKit

//https://replicate.com/lucataco/animate-diff
struct AnimateDiffView: View {
    
    var title: String
//    @State private var prompt = "masterpiece, best quality, 1girl, solo, cherry blossoms, hanami, pink flower, white flower, spring season, wisteria, petals, flower, plum blossoms, outdoors, falling petals, white hair, black eyes"
//    @State private var negativePrompt = "badhandv4, easynegative, ng_deepnegative_v1_75t, verybadimagenegative_v1.3, bad-artist, bad_prompt_version2-neg, teeth"
    @State private var prompt = ""
    @State private var negativePrompt = ""
    @StateObject var vm = AnimateDiffVM()
    
    var body: some View {
        Form {
            Section {
                TextField(text: $prompt,
                          prompt: Text("Enter a prompt to display an image"),
                          label: {})
                .submitLabel(.go)
                .onSubmit(of: .text) {
                    Task {
                        let animateDiffRequest = AnimateDiffRequest(prompt: prompt, n_prompt: negativePrompt)
                        await vm.postData(animateDiffRequest: animateDiffRequest)
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
                        let animateDiffRequest = AnimateDiffRequest(prompt: prompt, n_prompt: negativePrompt)
                        await vm.postData(animateDiffRequest: animateDiffRequest)
                    }
                }
            }
            if (vm.loading){
                ProgressView("Generating")
            }
            if let item = vm.items.first{
                if let url = item.output{
                    VStack {
                        let player = AVPlayer(url: url)
                        VideoPlayer(player: player)
                            .frame(height: 300)
                            .onAppear {
                                player.play()
                                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { _ in
                                                       player.seek(to: .zero)
                                                       player.play()
                                                   }
                            }.onDisappear {
                                player.pause()
                                NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)

                            }
                                
                    }
                }
            }
        }
        .navigationBarTitle(title, displayMode: .inline)
    }
}

#Preview {
    AnimateDiffView(title: "AnimateDiff")
}
