//
//  T2iAdapterSdxlSketchVM.swift
//  PythonToSwiftUI
//
//  Created by Zahoor Gorsi on 05/03/2024.
//

import Foundation

@MainActor class InstructPix2PixVM: ObservableObject {
    @Published var items = [InstructPix2PixResponse]()
    @Published var loading = false
    let endPoint = "instructPix2Pix"
    
//    func fetchData() async {
//        guard let downloadedItem: T2iAdapterSdxlSketchModel = await WebService().downloadData(fromURL: url) else {return}
//        items.append(downloadedItem)
//    }
    
    func postData(instructPix2PixRequest: InstructPix2PixRequest) async {
        self.loading = true
        self.items.removeAll()
        WebService().postInstructPix2PixModel(instructPix2PixRequest: instructPix2PixRequest,
                                              endPoint: endPoint) { res, err in
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
