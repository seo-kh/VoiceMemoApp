//
//  UserDefaultsManager.swift
//  VoiceMemo
//
//  Created by 서광현 on 2022/12/04.
//

import Foundation

class UserDefaultsManager {
    private let key = "UserDefaultsManager"
    
    func setVoiceMemos(_ voiceMemos: [VoiceMemoFolderModel]) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(voiceMemos), forKey: self.key)
    }
    
    func getVoiceMemos() -> [VoiceMemoFolderModel] {
         
        guard let data = UserDefaults.standard.value(forKey: self.key) as? Data,
              let voiceMemos = try? PropertyListDecoder().decode([VoiceMemoFolderModel].self, from: data)
        else {return []}
        return voiceMemos
    }
}
