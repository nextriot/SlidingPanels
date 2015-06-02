//
//  DetailViewController.swift
//  DT SlidingPanels
//
//  Created by Kyle Gillen on 31/05/2015.
//  Copyright (c) 2015 Next Riot. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  let contentView = UIView()
  let detailView = DetailView()
  
  private let kContentViewTopOffset: CGFloat = 64
  private let kContentViewBottomOffset: CGFloat = 64
  private let kContentViewAnimationDuration: NSTimeInterval = 1.4

  override func viewDidLoad() {
    super.viewDidLoad()
    
    contentView.backgroundColor = UIColor.whiteColor()
    contentView.frame = CGRect(x: 0, y: kContentViewTopOffset, width: view.bounds.width, height: view.bounds.height-kContentViewTopOffset)
    contentView.layer.shadowRadius = 5
    contentView.layer.shadowOpacity = 0.3
    contentView.layer.shadowOffset = CGSizeZero
    
    view.addSubview(contentView)
    
    let pan = UIPanGestureRecognizer(target: self, action: "handlePan:")
    view.addGestureRecognizer(pan)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func handlePan(pan: UIPanGestureRecognizer) {
    switch pan.state {
    case .Began:
      fallthrough
    case .Changed:
      contentView.frame.origin.y += pan.translationInView(view).y
      pan.setTranslation(CGPointZero, inView: view)
      
      let progress = (contentView.frame.origin.y - kContentViewTopOffset) / (view.bounds.height - kContentViewTopOffset - kContentViewBottomOffset)
      detailView.transitionProgress = progress
      
    case .Ended:
      fallthrough
    case .Cancelled:
      let progress = (contentView.frame.origin.y - kContentViewTopOffset) / (view.bounds.height - kContentViewTopOffset - kContentViewBottomOffset)
      if progress > 0.5 {
        let duration = NSTimeInterval(1-progress) * kContentViewAnimationDuration
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .allZeros, animations: { () -> Void in
          [self]
          
          self.detailView.transitionProgress = 1
          self.contentView.frame.origin.y = self.view.bounds.height - self.kContentViewBottomOffset
          
          }, completion: nil)
      }
      else {
        let duration = NSTimeInterval(progress) * kContentViewAnimationDuration
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .allZeros, animations: { () -> Void in
          [self]
          
          self.detailView.transitionProgress = 0
          self.contentView.frame.origin.y = self.kContentViewTopOffset
          
          }, completion: nil)
      }
      
    default:
      ()
    }
  }
  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
