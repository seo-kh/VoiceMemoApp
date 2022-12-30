//
//  VoiceMemoRecordViewController.swift
//  VoiceMemo
//
//  Created by 서광현 on 2022/12/30.
//

import UIKit
import SnapKit

final class VoiceMemoRecordViewController: UIViewController {
    let folder: VoiceMemoFolderModel
    
    init(folder: VoiceMemoFolderModel) {
        self.folder = folder
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var presenter = VoiceMemoRecordPresenter(viewController: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = presenter
        tableView.register(VoiceMemoRecordTableViewCell.self, forCellReuseIdentifier: VoiceMemoRecordTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var rightBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didRightBarButtonTapped))
        
        return barButton
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        return searchController
    }()
    
    private lazy var buttonView: UIView = {
        let buttonView = UIView()
        buttonView.backgroundColor = .systemGray6
        
        
        buttonView.addSubview(decorationView)
        
        return buttonView
    }()
    
    private lazy var decorationView: UIView = {
        let decorationView = UIView()
        decorationView.backgroundColor = .systemBackground
        decorationView.layer.borderColor = UIColor.systemGray.cgColor
        decorationView.layer.borderWidth = 3.0
        decorationView.layer.cornerRadius = 30.0
        
        return decorationView
    }()
    
    private lazy var recordButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        
        button.layer.cornerRadius = 25.0
        
        return button
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .secondaryLabel
        label.text = "Tap the Record button to start a Voice Memo."
        
        return label
    }()
    
    override func viewDidLoad() {
        presenter.viewDidLoad()
    }
}

extension VoiceMemoRecordViewController: VoiceMemoRecordProtocol {
    func setupNavigation() {
        title = folder.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.preferredSearchBarPlacement = .stacked
        
    }
    
    func setupLayout() {
        [tableView, buttonView, decorationView, recordButton, infoLabel]
            .forEach { view.addSubview($0) }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        buttonView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(120.0)
        }
        
        decorationView.snp.makeConstraints {
            $0.centerY.equalTo(buttonView).offset(-16.0)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(60.0)
        }
        
        recordButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(buttonView).offset(-16.0)
            $0.width.height.equalTo(50.0)
        }
        
        infoLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func didRightBarButtonAction() {
        print("HI")
    }
}

private extension VoiceMemoRecordViewController {
    @objc func didRightBarButtonTapped() {
        presenter.didRightBarButtonTapped()
    }
}
