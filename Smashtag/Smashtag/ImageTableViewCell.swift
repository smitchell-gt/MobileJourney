import UIKit
import Twitter

class ImageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetImageView: UIImageView!
    
    var tweetImage: Twitter.MediaItem? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let imageUrl = self?.tweetImage?.url
            
            if imageUrl != nil {
                let urlContents = try? Data(contentsOf: imageUrl!)
                
                if let imageData = urlContents {
                    DispatchQueue.main.async {
                        self?.tweetImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
    }
}
