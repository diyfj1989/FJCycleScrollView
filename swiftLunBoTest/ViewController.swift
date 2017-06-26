//
//  ViewController.swift
//  swiftLunBoTest
//
//  Created by fengjie on 16/11/17.
//  Copyright © 2016年 hanzgrp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FJCycleScrollViewDelegata{
    var tableView:UITableView!
    var cycleScrollView:FJCycleScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        
        setupTabelVew()
        setupCycleScrollView()
        tableView.tableHeaderView = cycleScrollView
    }
    
    func setupTabelVew() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func setupCycleScrollView() {
        cycleScrollView = FJCycleScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 240))
        cycleScrollView?.delegata = self
        cycleScrollView?.scrollInterval = 2
        cycleScrollView?.imageStrs = [
            "http://image.tianjimedia.com/uploadImages/2011/364/TN3MV61RWXH4.jpg",
            "http://image.tianjimedia.com/uploadImages/2011/364/94090Y9UL4I0.jpg",
            "http://dynamic-image.yesky.com/1080x-/uploadImages/2011/353/9EA6L431B61E.jpg",
            "http://image.tianjimedia.com/uploadImages/2012/005/U5ZBC8JRP7QS.jpg"
        ]
        cycleScrollView?.titles = [
            "test1",
            "test2",
            "test3",
            "test4"
        ]
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId:String! = "tableViewCell"
        var cell:FJTestTableViewCell? = tableView.dequeueReusableCell(withIdentifier: reuseId) as! FJTestTableViewCell?
        
//        if let _ = cell {
//            
//        } else {
//            cell = FJTestTableViewCell(style: .default, reuseIdentifier: reuseId)
//            cell?.selectionStyle = .none
//        }
        if cell == nil {
            cell = FJTestTableViewCell(style: .default, reuseIdentifier: reuseId)
            cell?.selectionStyle = .none
        }
//        cell?.titleLabel.text = "zhegewafas"
        
        return cell!
    }
    
    
    func cycleScrollView(_ cycleScrollView: FJCycleScrollView, didSelectAt index: Int) {
        print("image \(index) clicked")
    }
    
    
    
    
}
