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
    func didFolderButtonAction()
    func didTextChangedAction(_ text: String?)
}

protocol VoiceMemoFolderPresenterProtocol: AnyObject {
    func isFolderExist(_ exist: Bool)
}

final class VoiceMemoFolderPresenter: NSObject {
    private var viewController: VoiceMemoFolderProtocol?
    private let defaultFolders: [VoiceMemoFolderModel] = [
        VoiceMemoFolderModel(systemName: "waveform", title: "All Recordings", count: "42"),
        VoiceMemoFolderModel(systemName: "applewatch", title: "Watch Recordings", count: "4"),
        VoiceMemoFolderModel(systemName: "trash", title: "Recently Deleted", count: "1"),
    ]
    weak var delegate: VoiceMemoFolderPresenterProtocol?
    
    private var myFolders: [VoiceMemoFolderModel] = [] {
        didSet {
            if myFolders.isEmpty { delegate?.isFolderExist(false) }
            else { delegate?.isFolderExist(true) }
        }
    }
    private let manager = UserDefaultsManager()
    
    init(viewController: VoiceMemoFolderProtocol) {
        self.viewController = viewController
        self.myFolders = manager.getVoiceMemos()
    }
    
    func viewDidLoad() {
        viewController?.setupLayout()
        viewController?.setupNavigation()
    }
    
    func didRightBarButtonTapped() {
        viewController?.didRightBarButtonAction()
    }
    
    func didFolderButtonTapped() {
        viewController?.didFolderButtonAction()
    }
    
    func makeFolder(_ newFolder: VoiceMemoFolderModel) {
        self.myFolders.append(newFolder)
        self.manager.setVoiceMemos(myFolders)
        self.myFolders = self.manager.getVoiceMemos()
    }
    
    func didTextChanged(_ text: String?) {
        viewController?.didTextChangedAction(text)
    }
}

extension VoiceMemoFolderPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIViewController()
        vc.view.backgroundColor = .cyan
        viewController?.pushRecordView(viewController: vc)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return nil
        default: return myFolders.isEmpty ? "" : "My Folders"
        }
    }
}

extension VoiceMemoFolderPresenter: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return defaultFolders.count
        default:
            return myFolders.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VoiceMemoFolderTableViewCell.identifier, for: indexPath) as? VoiceMemoFolderTableViewCell
        
        switch indexPath.section {
        case 0:
            let folder = defaultFolders[indexPath.row]
            cell?.setup(folder: folder)
        default:
            let folder = myFolders[indexPath.row]
            cell?.setup(folder: folder)
        }
        return cell ?? UITableViewCell()
    }
    
    
}
