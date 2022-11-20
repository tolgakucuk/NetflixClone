import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        createTabBars()
    }
    
    private func createTabBars() {
        let homeTB = UINavigationController(rootViewController: HomeViewController())
        let upcomingTB = UINavigationController(rootViewController: UpcomingViewController())
        let searchTB = UINavigationController(rootViewController: SearchViewController())
        let downloadsTB = UINavigationController(rootViewController: DownloadsViewController())
        
        homeTB.tabBarItem.image = UIImage(systemName: "house")
        upcomingTB.tabBarItem.image = UIImage(systemName: "play.circle")
        searchTB.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        downloadsTB.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        homeTB.title = "Home"
        upcomingTB.title = "Coming Soon"
        searchTB.title = "Top Search"
        downloadsTB.title = "Downloads"
        
        tabBar.tintColor = .label
        
        
        setViewControllers([homeTB, upcomingTB, searchTB, downloadsTB], animated: true)
    }
}

