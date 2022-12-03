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
    
    private let rightBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: VoiceMemoFolderViewController.self, action: #selector(didRightBarButtonTapped))
    
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
        
        return button
    }()
    
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
        //
    }
    
    func pushRecordView(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

private extension VoiceMemoFolderViewController {
    @objc func didRightBarButtonTapped() {
        presenter.didRightBarButtonTapped()
    }
}
