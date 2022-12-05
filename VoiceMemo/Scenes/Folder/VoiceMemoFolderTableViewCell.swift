//
//  VoiceMemoFolderTableViewCell.swift
//  VoiceMemo
//
//  Created by 서광현 on 2022/12/04.
//

import UIKit
import SnapKit

/// 음성 메모 커스텀 셀: UIListContentConfiguration사용
///
/// - 참고링크 : [https://developer.apple.com/documentation/uikit/uilistcontentconfiguration/3601052-valuecell](https://developer.apple.com/documentation/uikit/uilistcontentconfiguration/3601052-valuecell)
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
        
        // editing accessory view
        let menuButton = UIButton(frame: .init(origin: .zero, size: .init(width: 24, height: 24)))
        menuButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        editingAccessoryView = menuButton
        
    }
    
    func hide() {
        
    }
}
