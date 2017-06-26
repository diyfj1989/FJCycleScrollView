//
//  FJCycleScrollView.swift
//  swiftLunBoTest
//
//  Created by fengjie on 16/11/17.
//  Copyright © 2016年 hanzgrp. All rights reserved.
//

import UIKit
import SDWebImage

public protocol FJCycleScrollViewDelegata {
    //点击图片的位置
    func cycleScrollView(_ cycleScrollView:FJCycleScrollView, didSelectAt index: Int)
}

extension FJCycleScrollViewDelegata {
    //点击图片的位置
    func cycleScrollView(_ cycleScrollView:FJCycleScrollView, didSelectAt index: Int){
        
    }
}

open class FJCycleScrollView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    fileprivate let baseNum:Int = 100
    open var scrollInterval:Double = 5
    
    fileprivate var timer:Timer?
    
    open var autoScroll:Bool = true {
        didSet{
            timer?.invalidate()
            timer = nil
            if autoScroll {
               configTimer()
            }
        }
    }
    
    //url图片
    open var images:[UIImage]? {
        didSet{
            if let _ = images {
                imageStrs = nil
                if autoScroll {
                    configTimer()
                }
            } else {
                timer?.invalidate()
                timer = nil
            }
            collectionView?.reloadData()
        }
    }
    
    open var imageStrs:[String]? {
        didSet{
            if let _ = imageStrs {
                images = nil
                if autoScroll {
                    configTimer()
                }
            } else {
                timer?.invalidate()
                timer = nil
            }
            collectionView?.reloadData()
        }
    }
    
    open var titles:[String]? {
        didSet{
            if let count = titles?.count {
                pageControl?.numberOfPages = count
            } else {
                pageControl?.numberOfPages = 0
            }
            collectionView?.reloadData()
        }
    }
    
    var collectionView:UICollectionView?
    open var pageControl:UIPageControl?
    
    open var delegata: FJCycleScrollViewDelegata?
    
    open var titleColor:UIColor?
    open var titleFont:UIFont?
    open var titleBackgroundColor:UIColor?
    open var titleAlignmet:NSTextAlignment?
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configView() {
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = bounds.size
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(FJCycleScrollCell.self, forCellWithReuseIdentifier: "FJCycleScrollCell")
        addSubview(collectionView!)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: bounds.height - 20, width: bounds.width, height: 20))
        pageControl!.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        pageControl!.hidesForSinglePage = true
        addSubview(pageControl!)
    }
    
    fileprivate func configTimer () {
        
        timer = Timer.scheduledTimer(timeInterval: scrollInterval, target: self, selector: #selector(atuomaticScroll), userInfo: nil, repeats: true)
        
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    
     func atuomaticScroll() {
        var page:Int = Int(Float((self.collectionView?.contentOffset.x)! + 0.5 * (self.collectionView?.frame.width)!) / Float((self.collectionView?.frame.width)!))
        page += 1
        if (page >= self.baseNum * (self.titles?.count)!) {
            page = 0
        }
        self.collectionView?.scrollToItem(at: IndexPath(row: page, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = titles?.count {
            return count * baseNum
        } else {
            return 0
        }
    }
    
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FJCycleScrollCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FJCycleScrollCell", for: indexPath) as! FJCycleScrollCell
        
        cell.titleLabel?.textColor = titleColor ?? UIColor.white
        cell.titleLabel?.font = titleFont ?? UIFont.systemFont(ofSize: 16)
        cell.titleBackgroundView?.backgroundColor = titleBackgroundColor ?? UIColor.black.withAlphaComponent(0.1)
        cell.titleLabel?.textAlignment = titleAlignmet ?? NSTextAlignment.left
        
        let index:Int = indexPath.row % (self.titles?.count)!
        if let _imageStrs = imageStrs {
            if index < _imageStrs.count {
                cell.imageView?.sd_setImage(with: URL(string: _imageStrs[index]))
            }
        } else if let _images = images {
            if index < _images.count {
                cell.imageView?.image = _images[index]
            }
        }
        
        if let title = titles?[index] {
            cell.titleLabel?.text = title
        }
        
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row % (self.titles?.count)!
        delegata?.cycleScrollView(self, didSelectAt: index)
    }
    
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            var page:Int! = Int(Float((self.collectionView?.contentOffset.x)! + 0.5 * (self.collectionView?.frame.width)!) / Float((self.collectionView?.frame.width)!))
            page = page % (self.titles?.count)!
            pageControl?.currentPage = page
        }
    }
    
    open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if autoScroll {
            timer?.invalidate()
            timer = nil
        }
    }
    
    open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if autoScroll {
            timer?.invalidate()
            timer = nil
            configTimer()
        }
    }
    
}

