//
//  T2iAdapterSdxlSketchVM.swift
//  PythonToSwiftUI
//
//  Created by Zahoor Gorsi on 05/03/2024.
//

import Foundation

@MainActor class T2iAdapterSdxlSketchVM: ObservableObject {
    @Published var items = [T2iAdapterSdxlSketchResponse]()
    @Published var loading = false
    let endpoint = "t2iAdapterSdxlSketch"
    
//    func fetchData() async {
//        guard let downloadedItem: T2iAdapterSdxlSketchModel = await WebService().downloadData(fromURL: url) else {return}
//        items.append(downloadedItem)
//    }
    
    func postData(t2iAdapterSdxlSketchRequest: T2iAdapterSdxlSketchRequest) async {
        self.loading = true
        self.items.removeAll()
        WebService().postT2iAdapterSdxlSketch(t2iAdapterSdxlSketchRequest: t2iAdapterSdxlSketchRequest
                                              , endPoint: endpoint) { res, err in
            Task{ @MainActor in
                self.loading = false
                if (err == nil){
                    if let t2iAdapterSdxlSketchModel = res{
                        Task{ @MainActor in
                            self.items.append(t2iAdapterSdxlSketchModel)
                        }
                    }
                }
            }
        }
    }
}
