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

class FileViewController: UIViewController, FileViewControllerProtocol {
    var rootFileModel: FileModelProtocol
    var avatarFactory: AvatarFactoryProtocol?
    var fileManager: FileManagerProtocol?
    var dataSource: [FileModelProtocol]?
    func setAvatarFactory(avatarFactory: AvatarFactoryProtocol) {
        self.avatarFactory = avatarFactory
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    init(rootFileModel: FileModel) {
        self.rootFileModel = rootFileModel
        self.dataSource = self.fileManager?.recentFileModels()
        super.init(nibName: nil, bundle: nil)
        self.title = "File"
    }
    
    required init?(coder: NSCoder) {
        self.rootFileModel = FileModel(path: "/")
        super.init(coder: coder)
        self.title = "File"
    }
    
    convenience init() {
        self.init(rootFileModel: FileModel(path: "/"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let icon = UIImage.init(named: "carbon_about_icon") ?? UIImage.init()
        if let imageView = self.avatarFactory?.imageView(with: icon) {
            self.view.addSubview(imageView)
        }
        
        view.backgroundColor = UIColor.white
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 100, width: view.bounds.size.width, height: view.bounds.size.height)
        
        // MARK: S2: Protocol defined in ObjC, registered in ObjC, resolved in Swift
        print("S2: \(String(describing: avatarFactory))")
    }
}

extension FileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "carbon")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "carbon")
        }
        let model = self.dataSource?[indexPath.row]
        cell?.textLabel?.text = model?.fileName
        cell?.detailTextLabel?.text = model?.filePath
        return cell ?? UITableViewCell(style: .subtitle, reuseIdentifier: "carbon")
    }
}
