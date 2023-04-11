//
//  DetailsViewController.swift
//  ITunes
//
//  Created by Alex Serhiiev on 11.04.2023.
//

import UIKit
import AVKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var realeseDateLabel: UILabel!
    
    @IBOutlet weak var voteLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var videoView: UIView!
    
    var data: LocalModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let data = data else { return }
        
        navigationItem.rightBarButtonItem = .init(title: nil, image: UIImage(systemName: "square.and.arrow.up"), target: self, action: #selector(share))
        imageView.sd_setImage(with: .init(string: data.artworkUrl100))
        nameLabel.text = data.trackName
        
        let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "MM/dd/yyyy"
        let string = dateFormatter.string(from: data.releaseDate)
        
        realeseDateLabel.text = string
        voteLabel.text = data.primaryGenreName
        overviewLabel.text = data.longDescription
        guard let url = data.previewURL else {
            videoView.isHidden = true
            return
        }
        configureVideo(url: url)
    }
    
    @objc func share() {
        let text = data?.trackViewURL
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    var player: AVPlayer?
    var playerController: AVPlayerViewController?
    func removePlayer() {
        player?.pause()
        player = nil
        playerController?.player?.pause()
        playerController?.player = nil
        if let view = playerController?.view {
            videoView.willRemoveSubview(view)
        }
        playerController?.view.removeFromSuperview()
        playerController = nil
    }
    
    func configureVideo(url: String) {
        let url = URL(string:url)
        removePlayer()
        player = AVPlayer(url: url!)
        playerController = AVPlayerViewController()
        playerController?.player = player
        self.videoView.addSubview((playerController?.view)!)
        playerController?.view.frame = CGRect(x: 0, y: 0, width: self.videoView.bounds.width, height: self.videoView.bounds.height)
        player?.play()
    }
    
}
