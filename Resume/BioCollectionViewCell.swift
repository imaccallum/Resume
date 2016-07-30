//
//  SwapCollectionViewCell.swift
//  TinderNavDemo
//
//  Created by Ian MacCallum on 7/7/15.
//  Copyright © 2015 Ian MacCallum. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

class BioCollectionViewCell: UICollectionViewScrollCell {
  @IBOutlet weak var bottomShapeView: ShapeView!
  @IBOutlet weak var movieView: AVPlayerView!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    bottomShapeView.shapes = ShapeLayout.homeTopLayout()

  }
  
  override func didScroll(withOffset offset: CGPoint) {
    let _ = offset.y / frame.height
  }

  override func didEndDisplay() {
    movieView.playerLayer.player?.pause()
  }
  
  override func willBeginDisplay() {
    movieView.playerLayer.player?.play()
  }
}

class AVPlayerView: UIView {
  var playerLayer: AVPlayerLayer!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    guard let path = NSBundle.mainBundle().pathForResource("movie", ofType: "mp4") else { return }
    let url = NSURL(fileURLWithPath: path)
    let player = AVPlayer(URL: url)
    playerLayer = AVPlayerLayer(player: player)
    layer.addSublayer(playerLayer)
    playerLayer.player?.play()
    
    let tap = UITapGestureRecognizer(target: self, action: "viewTapped:")
    addGestureRecognizer(tap)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    playerLayer?.frame = layer.bounds
  }
  
  func viewTapped(sender: UITapGestureRecognizer) {
    if playerLayer.player?.rate == 0 {
      playerLayer.player?.play()
    } else {
      playerLayer.player?.pause()
    }
  }
  
}

class LabelShapeView: ShapeView {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    shapes = [
      Shape(tile: CGPoint(x: 2, y: 2),    type: .Triangle,    size: .SM,   direction: .Left),
      Shape(tile: CGPoint(x: 2, y: 12),   type: .Triangle,    size: .SM,   direction: .Top),
      Shape(tile: CGPoint(x: 92, y: 2),   type: .Triangle,    size: .SM,   direction: .Right),
      Shape(tile: CGPoint(x: 92, y: 12),  type: .Triangle,    size: .SM,   direction: .Bottom),
    ]
  }
}