//
//  FileViewController.swift
//  FileModule
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import UIKit
import BasicModule

class FileViewController: UIViewController {
    var fileManager: FileManagerProtocol?
    var dataSource: [FileModelProtocol]?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.title = "File"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self.fileManager?.recentFileModels()
        
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 100
    }
}

extension FileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CarbonGraph")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CarbonGraph")
        }
        let model = self.dataSource?[indexPath.row]
        cell?.textLabel?.text = model?.fileName
        cell?.detailTextLabel?.text = model?.filePath
        return cell ?? UITableViewCell(style: .subtitle, reuseIdentifier: "CarbonGraph")
    }
}
