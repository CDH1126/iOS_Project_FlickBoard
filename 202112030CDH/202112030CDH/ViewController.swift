import UIKit

let movie = ["야당", "마인크래프트", "썬더볼츠", "진격의 거인", "야당2"]

struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let weeklyBoxOfficeList: [WeeklyBoxOfficeList]
}

struct WeeklyBoxOfficeList: Codable {
    let movieNm: String
    let audiCnt: String
    let audiAcc: String
    let rank: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!

    var movieData: MovieData?
    var movieURL = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=a98a0bc5260826880d584b21ac65109d&targetDt="

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        movieURL += makeYesterdayString()
        getData()
    }

    func makeYesterdayString() -> String {
        let y = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let dateF = DateFormatter()
        dateF.dateFormat = "yyyyMMdd"
        return dateF.string(from: y)
    }

    func getData() {
        guard let url = URL(string: movieURL) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error!)
                return
            }
            guard let JSONdata = data else { return }
            let dataString = String(data: JSONdata, encoding: .utf8)
            // print(dataString!) // 주간 영화 순위 JSON을 확인할 수 있음

            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(MovieData.self, from: JSONdata)
                self.movieData = decodedData
                print(decodedData.boxOfficeResult.weeklyBoxOfficeList[0].movieNm)
                print(decodedData.boxOfficeResult.weeklyBoxOfficeList[0].audiAcc)
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! DetailViewController
        let myIndexPath = table.indexPathForSelectedRow!
        let row = myIndexPath.row
        dest.movieName = movieData?.boxOfficeResult.weeklyBoxOfficeList[row].movieNm ?? "정보 없음"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData?.boxOfficeResult.weeklyBoxOfficeList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        guard let movie = movieData?.boxOfficeResult.weeklyBoxOfficeList[indexPath.row] else { return UITableViewCell() }

        cell.movieName.text = "[\(movie.rank)위] \(movie.movieNm)"

        if let aCnt = Int(movie.audiCnt) {
            let numF = NumberFormatter()
            numF.numberStyle = .decimal
            cell.audiCount.text = "주간: \(numF.string(from: NSNumber(value: aCnt)) ?? "0")명"
        }

        if let aAcc = Int(movie.audiAcc) {
            let numF = NumberFormatter()
            numF.numberStyle = .decimal
            cell.audiAccumulate.text = "누적: \(numF.string(from: NSNumber(value: aAcc)) ?? "0")명"
        }

        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "주간 박스오피스(영화진흥위원회 제공: " + makeYesterdayString() + ")"
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "made by CDH"
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.description)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
