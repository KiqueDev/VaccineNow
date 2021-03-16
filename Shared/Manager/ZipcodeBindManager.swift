//
//  ZipcodeBindManager.swift
//  VaccineNow (iOS)
//
//  Created by Enrique on 12/9/20.
//

import Foundation

class ZipcodeBindManager: ObservableObject {
    @Published var text = "" {
        didSet {
            if text.count > characterLimit && oldValue.count <= characterLimit {
                text = oldValue
            }
        }
    }
    let characterLimit: Int
    
    init(limit: Int = 5){
        characterLimit = limit
    }
}
