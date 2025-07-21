import UIKit
import WebKit // webView: WKWebView! 을 위한 임포트

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var nameLabel: UILabel!
    var movieName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = movieName
        navigationItem.title = movieName
    //let urlKorString =
    // "https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query="+movieName
        
        let urlKorString = "https://www.google.com/search?q=" + movieName
        let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
