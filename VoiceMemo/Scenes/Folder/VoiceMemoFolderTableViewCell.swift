//
//  VoiceMemoFolderTableViewCell.swift
//  VoiceMemo
//
//  Created by 서광현 on 2022/12/04.
//

import UIKit
import SnapKit

final class VoiceMemoFolderTableViewCell: UITableViewCell {
    /// Identfier설정
    static let identifier = "VoiceMemoFolderTableViewCell"
    
    /// 커스텀셀 설정하기
    func setup(folder: VoiceMemoFolderModel) {
        // accessoryType, selectionStyle
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        // custom data
        var cell = UIListContentConfiguration.valueCell()
        cell.image = folder.image
        cell.text = folder.title
        cell.secondaryText = folder.count
        
        self.contentConfiguration = cell
    }
}
