import UIKit
import ReactiveCocoa
import ReactiveSwift
import Twitter

class MentionsTableViewController: UITableViewController {

    var viewModel: MentionsTableViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows: Int
        
        if section == 0 {
            numberOfRows = viewModel.getImages().count
        } else if section == 1 {
            numberOfRows = viewModel.getHashtagMentions().count
        } else if section == 2 {
            numberOfRows = viewModel.getUserMentions().count
        } else if section == 3 {
            numberOfRows = viewModel.getUrlMentions().count
        } else {
            numberOfRows = 0
        }
        
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "image", for: indexPath)
            if let imageCell = cell as? ImageTableViewCell {
                imageCell.tweetImage = viewModel.getImages()[indexPath.row]
            }
        } else if indexPath.section == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "hashtagMention", for: indexPath)
            if let hashtagCell = cell as? HashtagMentionTableViewCell {
                hashtagCell.hashtag = viewModel.getHashtagMentions()[indexPath.row].keyword
            }
        } else if indexPath.section == 2 {
            cell = tableView.dequeueReusableCell(withIdentifier: "userMention", for: indexPath)
            if let userCell = cell as? UserMentionTableViewCell {
                userCell.username = viewModel.getUserMentions()[indexPath.row].keyword
            }
        } else if indexPath.section == 3 {
            cell = tableView.dequeueReusableCell(withIdentifier: "urlMention", for: indexPath)
            if let urlCell = cell as? UrlMentionTableViewCell {
                urlCell.url = viewModel.getUrlMentions()[indexPath.row].keyword
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "resueIdentifier", for: indexPath)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = ""
        
        if section == 0 {
            if viewModel.getImages().count > 0 {
                title = "Images"
            }
        } else if section == 1 {
            if viewModel.getHashtagMentions().count > 0 {
                title = "Hashtags"
            }
        } else if section == 2 {
            if viewModel.getUserMentions().count > 0 {
                title = "Users"
            }
        } else if section == 3 {
            if viewModel.getUrlMentions().count > 0 {
                title = "URLs"
            }
        }
        
        return title
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
