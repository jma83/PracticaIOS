import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    var startRouteCoordinator: StartRouteCoordinator!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        let userManager = UserManager()
        let bookManager = BookManager()
        startRouteCoordinator = StartRouteCoordinator(userManager: userManager, bookManager: bookManager)
        window?.rootViewController = startRouteCoordinator.rootViewController
        
        window?.makeKeyAndVisible()
        
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.medianet.MyFavouriteSongs" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls.last!
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        // TODO: Load Managed Object Model
        return NSManagedObjectModel(contentsOf: Bundle.main.url(forResource: "MyLibrary", withExtension: "momd")!)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        // TODO: Create persistent store coordinator

        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")

        // TODO: Create SQLite persistent store at the URL
        
        do{
           try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        }catch {
            print("Error adding store coordinator")
        }
            
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator

        // TODO: configure the Managed Object Context with main queue concurrency type
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        moc.persistentStoreCoordinator = coordinator
        
        return moc
        
    }()

    // MARK: - Core Data Saving support

    func saveContext ()
    {
        // TODO: save Managed Object Contexts if it has changes
        do {
            try managedObjectContext.save()
        }catch let error{
            print("Error: \(error)" )
        }
    }
    
}
