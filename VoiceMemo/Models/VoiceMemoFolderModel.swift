//
//  VoiceMemoFolderModel.swift
//  VoiceMemo
//
//  Created by 서광현 on 2022/12/04.
//

import UIKit

struct VoiceMemoFolderModel: Codable, Equatable {
    let systemName: String
    let title: String
    let count: String
    
    init(systemName: String, title: String, count: String) {
        self.systemName = systemName
        self.title = title
        self.count = count
    }
    
    var image: UIImage? { UIImage(systemName: systemName) }
}
