//
//  RoomsViewController.swift
//  DT SlidingPanels
//
//  Created by Kyle Gillen on 30/05/2015.
//  Copyright (c) 2015 Next Riot. All rights reserved.
//

import UIKit

class RoomsViewController: UICollectionViewController {
  
  let kRoomCellScaling: CGFloat = 0.6

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    setupCollectionView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setupCollectionView() {
    let screenSize = UIScreen.mainScreen().bounds.size
    let cellWidth = floor(screenSize.width * kRoomCellScaling)
    let cellHeight = floor(screenSize.height * kRoomCellScaling)
    
    let insetX = (CGRectGetWidth(view.bounds) - cellWidth) / 2.0
    let insetY = (CGRectGetHeight(view.bounds) - cellHeight) / 2.0
    
    let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
    layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
    collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
    collectionView?.reloadData()
  }
  
  
}

extension RoomsViewController: UICollectionViewDataSource {
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
    return cell
  }

}

extension RoomsViewController: UICollectionViewDelegate {
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DetailViewController") as! UIViewController
    presentViewController(controller, animated: true, completion: nil)
  }
  
}

extension RoomsViewController: UIScrollViewDelegate {
  
  override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
    let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
    
    var offset = targetContentOffset.memory
    let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
    
//    print("\(index) ")
//    println("\(offset.x, scrollView.contentInset.left, cellWidthIncludingSpacing)")
    
    let roundedIndex = round(index)
    
//    print("\(roundedIndex) ")
//    println("\(cellWidthIncludingSpacing, scrollView.contentInset.left, scrollView.contentInset.top)")
    
    offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
    targetContentOffset.memory = offset
  }
  
}

