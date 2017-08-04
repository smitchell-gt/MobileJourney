import UIKit
import Twitter

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetImageView: UIImageView!
    
    var tweetImage: Twitter.MediaItem? {
        didSet {
            fetchImage()
        }
    }
    
    //TOOD: Doesn't work
    
    private func fetchImage() {
        if let imageURL = tweetImage?.url {
            // TODO: blocks main thread
            if let imageData = try? Data(contentsOf: imageURL) {
                tweetImageView?.image = UIImage(data: imageData)
            }
        }
        
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            if let imageUrl = self?.tweetImage?.url {
//                let urlContents = try? Data(contentsOf: imageUrl)
//                
//                if let imageData = urlContents {
//                    DispatchQueue.main.async {
//                        self?.tweetImageView.image = UIImage(data: imageData)
//                    }
//                }
//            }
//        }
    }
}
