//
//  VoiceMemoFolderViewController.swift
//  VoiceMemo
//
//  Created by 서광현 on 2022/12/04.
//

import UIKit
import SnapKit

final class VoiceMemoFolderViewController: UIViewController {
    private lazy var presenter = VoiceMemoFolderPresenter(viewController: self)
    
    private lazy var rightBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didRightBarButtonTapped))
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.delegate = presenter
        tableView.dataSource = presenter
        
        tableView.register(VoiceMemoFolderTableViewCell.self, forCellReuseIdentifier: VoiceMemoFolderTableViewCell.identifier)
        
        return tableView
    }()

    private lazy var folderButtonView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "folder.badge.plus"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didFolderButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    private var alert: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
}

extension VoiceMemoFolderViewController: VoiceMemoFolderProtocol {
    func setupNavigation() {
        navigationItem.title = "Voice Memos"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    func setupLayout() {
        [tableView, folderButtonView]
            .forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        folderButtonView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20.0)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(20.0)
            $0.width.height.equalTo(28.0)
        }
        
        folderButtonView.imageView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func didRightBarButtonAction() {
    }
    
    func didFolderButtonAction() {
        alert = UIAlertController(title: "New Folder", message: "Enter a name for folder.", preferredStyle: .alert)
        alert?.addTextField {[weak self] textField in
            textField.placeholder = "Name"
            textField.addTarget(self, action: #selector(self?.didTextChanged), for: .editingChanged)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        let save = UIAlertAction(title: "Save", style: .default) {[weak self] _ in
            guard let textField = self?.alert?.textFields?.first,
                  let title = textField.text
            else {
                return
            }
            let newFolder = VoiceMemoFolderModel(image: UIImage(systemName: "folder"), title: title, count: "0")
            self?.presenter.makeFolder(newFolder)
            self?.tableView.reloadData()
        }
        
        alert?.addAction(cancel)
        save.isEnabled = false
        alert?.addAction(save)
        
        present(alert!, animated: true)
    }
    
    func pushRecordView(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func didTextChangedAction(_ text: String?) {
        alert?.actions.last?.isEnabled = !(text?.isEmpty ?? true)
        
    }
}

private extension VoiceMemoFolderViewController {
    @objc func didRightBarButtonTapped() {
        presenter.didRightBarButtonTapped()
    }
    
    @objc func didFolderButtonTapped() {
        presenter.didFolderButtonTapped()
    }
    
    @objc func didTextChanged(_ sender: UITextField) {
        presenter.didTextChanged(sender.text)
    }
}
