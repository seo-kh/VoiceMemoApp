//
//  VoiceMemoRecordTableViewCell.swift
//  VoiceMemo
//
//  Created by 서광현 on 2022/12/30.
//

import UIKit
import SnapKit

final class VoiceMemoRecordTableViewCell: UITableViewCell {
    static let identifier = "VoiceMemoRecordTableViewCell"
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    func setup() {
        layout()
        
        contentLabel.text = "content"
        dateLabel.text = "date"
        timeLabel.text = "time"
    }
    
    /// 커스텀셀 설정하기
    private func layout() {
        selectionStyle = .none
        
        [contentLabel, dateLabel, timeLabel ]
            .forEach { addSubview($0) }
        
        let spacing: CGFloat = 12.0
        
        contentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(spacing)
            $0.top.equalToSuperview().inset(spacing / 2.0)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(contentLabel)
            $0.bottom.equalToSuperview().inset(spacing / 2.0)
            $0.top.equalTo(contentLabel.snp.bottom).offset(spacing / 2.0)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.top)
            $0.bottom.equalToSuperview().inset(spacing / 2.0)
            $0.trailing.equalToSuperview().inset(spacing)
        }
    }
}
