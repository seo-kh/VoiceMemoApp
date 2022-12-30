//
//  VoiceMemoRecordPresenter.swift
//  VoiceMemo
//
//  Created by 서광현 on 2022/12/30.
//

import UIKit
import SnapKit

protocol VoiceMemoRecordProtocol {
    func setupNavigation()
    func setupLayout()
    func didRightBarButtonAction()
}

final class VoiceMemoRecordPresenter: NSObject {
    private var viewController: VoiceMemoRecordProtocol?
    
    init(viewController: VoiceMemoRecordProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupNavigation()
        viewController?.setupLayout()
    }
    
    func didRightBarButtonTapped() {
        viewController?.didRightBarButtonAction()
    }
}

extension VoiceMemoRecordPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VoiceMemoRecordTableViewCell.identifier, for: indexPath) as? VoiceMemoRecordTableViewCell
        
        cell?.setup()
        
        return cell ?? UITableViewCell()
    }
    
    
}
