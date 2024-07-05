import UIKit
import YandexMapKit

typealias LaunchOptionsKey = [UIApplication.LaunchOptionsKey: Any]

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: LaunchOptionsKey?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.black
        ]
        let mainViewController = DogBreedsBuilder().setTitle("Породы собак").build()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        navigationController.navigationBar.prefersLargeTitles = true
		mainViewController.navigationItem.rightBarButtonItem = BlockBarButtonItem(
			icon: UIImage(named: "profile") ?? UIImage(),
			{ 
				let presenter = ProfilePresenter()
				let interactor = ProfileInteractor(presenter: presenter)
				let controller = ProfileViewController(interactor: interactor)
				presenter.viewController = controller
				navigationController.pushViewController(controller, animated: true)
			})
		mainViewController.navigationItem.leftBarButtonItem = BlockBarButtonItem(
			icon: UIImage(named: "animationDog") ?? UIImage(),
			{
				let controller = OnboardingViewController()
				navigationController.pushViewController(controller, animated: true)
			})
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

		YMKMapKit.setApiKey("1e232438-0f83-4a20-a958-485a2e54d4d6")
        return true
    }
}


