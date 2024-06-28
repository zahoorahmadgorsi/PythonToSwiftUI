//
//  T2iAdapterSdxlSketchVM.swift
//  PythonToSwiftUI
//
//  Created by Zahoor Gorsi on 05/03/2024.
//

import Foundation

@MainActor class AnimateDiffVM: ObservableObject {
    @Published var items = [AnimateDiffResponse]()
    @Published var loading = false
    let endPoint = "animateDiff"
    
//    func fetchData() async {
//        guard let downloadedItem: T2iAdapterSdxlSketchModel = await WebService().downloadData(fromURL: url) else {return}
//        items.append(downloadedItem)
//    }
    
    func postData( animateDiffRequest: AnimateDiffRequest) async {
        self.loading = true
        WebService().postAnimateDiffModel(animateDiffRequest: animateDiffRequest,endPoint: endPoint) { res, err in
            Task{ @MainActor in
                self.loading = false
                if (err == nil){
                    if let t2iAdapterSdxlSketchModel = res{
                        self.items.append(t2iAdapterSdxlSketchModel)
                    }
                }
            }
        }
    }
}
