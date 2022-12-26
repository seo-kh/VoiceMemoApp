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
    func setup(
        folder: VoiceMemoFolderModel?,
        renameAction: ((UIAction)->Void)? = nil,
        deleteAction: ((UIAction)->Void)? = nil
    ) {
        // accessoryType, selectionStyle
        accessoryType = .disclosureIndicator
        selectionStyle = .none
        
        // custom data
        var cell = UIListContentConfiguration.valueCell()
        if let folder = folder {
            cell.image = folder.image
            cell.text = folder.title
            cell.secondaryText = folder.count
        }
        
        self.contentConfiguration = cell
        
        // editing accessory view
        let menuButton = UIButton(frame: .init(origin: .zero, size: .init(width: 24, height: 24)))
        menuButton.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        editingAccessoryView = menuButton
        
        /// menu button: [https://medium.nextlevelswift.com/creating-a-native-popup-menu-over-a-uibutton-or-uinavigationbar-645edf0329c4](https://medium.nextlevelswift.com/creating-a-native-popup-menu-over-a-uibutton-or-uinavigationbar-645edf0329c4)
        if let renameAction = renameAction,
           let deleteAction = deleteAction {
            menuButton.showsMenuAsPrimaryAction = true
            menuButton.menu = menu(
                renameAction: renameAction,
                deleteAction: deleteAction
            )
        }
    }
    
    private func menu(
        renameAction: @escaping (UIAction)->Void,
        deleteAction: @escaping (UIAction)->Void
    ) -> UIMenu {
        let rename = UIAction(title: "Rename", image: UIImage(systemName: "pencil"), handler: renameAction)
        
        let delete = UIAction(title: "Delete",image: UIImage(systemName: "trash"), attributes: .destructive, handler: deleteAction)
        
        return UIMenu(title: "", options: .displayInline, children: [rename, delete])
    }
}
