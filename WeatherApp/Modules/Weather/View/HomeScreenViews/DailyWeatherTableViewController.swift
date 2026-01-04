import UIKit

class DailyWeatherTableViewController: UITableViewController {
    var data = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var mintemp = ["58°", "58°", "58°", "58°", "58°", "58°", "58°"]
    var maxtemp = ["58°", "58°", "58°", "58°", "58°", "58°", "58°"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = ColorConstant.cardBackgroundColor
        self.tableView.layer.cornerRadius = 20
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(WeatherDayTableViewCell.self, forCellReuseIdentifier: "WeatherDayTableViewCell")
        self.tableView.register(TenDayTableViewCell.self, forCellReuseIdentifier: "TenDayTableViewCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TenDayTableViewCell", for: indexPath) as! TenDayTableViewCell
            cell.configure(with: "10 DAY FORECAST")
            cell.layer.cornerRadius = 20
            cell.backgroundColor = .clear
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherDayTableViewCell", for: indexPath) as! WeatherDayTableViewCell
            cell.layer.cornerRadius = 20
            cell.backgroundColor = .clear
            cell.configure(with: data[indexPath.row - 1], mintemp: mintemp[indexPath.row - 1], maxtemp: maxtemp[indexPath.row - 1])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = data[indexPath.row]
        print("You selected: \(selectedItem)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}
