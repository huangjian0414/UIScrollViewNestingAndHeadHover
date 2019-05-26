//
//  firstViewController.swift
//  Test
//
//  Created by huangjian on 2019/4/30.
//  Copyright © 2019 huangjian. All rights reserved.
//

import Foundation
import UIKit

class firstViewController :  UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var table : UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.darkGray

        table = UITableView.init(frame: CGRect.init(x: 0, y: 30, width: view.bounds.width, height: view.bounds.height-30-88-34), style: .plain)
        table.delegate=self
        table.dataSource=self
        table.showsVerticalScrollIndicator=false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "999")
        view.addSubview(table)
        
        test_scrollView=table
        
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "999")
        cell?.textLabel?.text="第\(indexPath.row+1)行"
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
