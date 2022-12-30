//
//  UserDefaultsManager.swift
//  VoiceMemo
//
//  Created by 서광현 on 2022/12/04.
//

import Foundation

/// 메모저장을 위한 UserDefaults
///
/// - [https://swifty-cody.tistory.com/40](https://swifty-cody.tistory.com/40)
class UserDefaultsManager {
    private let key = "UserDefaultsManager"
    
    func deleteMemo(_ voiceMemo: VoiceMemoFolderModel) {
        var voiceMemos: [VoiceMemoFolderModel] = getVoiceMemos()
        voiceMemos = voiceMemos.filter { $0.title != voiceMemo.title }
        setVoiceMemos(voiceMemos)
    }
    
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
