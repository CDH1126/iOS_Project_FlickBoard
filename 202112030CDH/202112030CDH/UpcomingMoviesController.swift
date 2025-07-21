//
//  UpcomingMoviesController.swift
//  202112030CDH
//
//  Created by Induk CS on 2025/05/28.
//

import UIKit
import WebKit

class UpcomingMoviesController: UIViewController {
    @IBOutlet weak var webView2: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlKorString = "https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&qvt=0&query=개봉예정영화"
        let urlString = urlKorString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string:urlString) else { return }
        let request = URLRequest(url: url)
        webView2.load(request)

        // Do any additional setup after loading the view.
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
