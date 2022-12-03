//
//  VoiceMemoFolderPresenter.swift
//  VoiceMemo
//
//  Created by 서광현 on 2022/12/04.
//

import UIKit

protocol VoiceMemoFolderProtocol {
    func setupNavigation()
    func setupLayout()
    func didRightBarButtonAction()
    func pushRecordView(viewController: UIViewController)
}

final class VoiceMemoFolderPresenter: NSObject {
    private var viewController: VoiceMemoFolderProtocol?
    private var folders: [VoiceMemoFolderModel] = [
        VoiceMemoFolderModel(image: .init(systemName: "waveform"), title: "All Recordings", count: "42"),
        VoiceMemoFolderModel(image: .init(systemName: "applewatch"), title: "Watch Recordings", count: "4"),
        VoiceMemoFolderModel(image: .init(systemName: "trash"), title: "Recently Deleted", count: "1"),
    ]
    
    init(viewController: VoiceMemoFolderProtocol) {
        self.viewController = viewController
    }
    
    func viewDidLoad() {
        viewController?.setupLayout()
        viewController?.setupNavigation()
    }
    
    func didRightBarButtonTapped() {
        viewController?.didRightBarButtonAction()
    }
}

extension VoiceMemoFolderPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIViewController()
        vc.view.backgroundColor = .cyan
        viewController?.pushRecordView(viewController: vc)
    }
}

extension VoiceMemoFolderPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VoiceMemoFolderTableViewCell.identifier, for: indexPath) as? VoiceMemoFolderTableViewCell
        
        let folder = folders[indexPath.row]
        cell?.setup(folder: folder)
        return cell ?? UITableViewCell()
    }
    
    
}
