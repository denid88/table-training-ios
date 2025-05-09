import UIKit

class UITableViewController: UIViewController {
    let tableView: UITableView = {
        let uiTableView = UITableView()
        uiTableView.rowHeight = 60.0
        return uiTableView
    }()
    
    var data = [
        // Fruits
        ("Apple", "Fruit"),
        ("Banana", "Fruit"),
        ("Cherry", "Fruit"),
        ("Elderberry", "Fruit"),
        ("Grapes", "Fruit"),
        ("Mango", "Fruit"),
        ("Orange", "Fruit"),
        ("Peach", "Fruit"),
        ("Pear", "Fruit"),
        ("Strawberry", "Fruit"),
        
        // Vegetables
        ("Carrot", "Vegetable"),
        ("Broccoli", "Vegetable"),
        ("Tomato", "Vegetable"),
        ("Cucumber", "Vegetable"),
        ("Potato", "Vegetable"),
        ("Lettuce", "Vegetable"),
        ("Onion", "Vegetable"),
        ("Spinach", "Vegetable"),
        ("Peas", "Vegetable"),
        ("Bell Pepper", "Vegetable")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad is called")
        view.backgroundColor = .blue
        setupTable()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear is called")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear is called")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear is called")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
    }
        
    private func setupTable() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        let editButton = UIBarButtonItem(
            image: UIImage(systemName: "pencil"), // Іконка
            style: .plain,
            target: self,
            action: #selector(toggleEditing)
        )
        
        navigationItem.rightBarButtonItem = editButton
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
               
        NSLayoutConstraint.activate([
           tableView.topAnchor.constraint(equalTo: view.topAnchor),
           tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    @objc func toggleEditing() {
       tableView.setEditing(!tableView.isEditing, animated: true)
       navigationItem.rightBarButtonItem?.image = tableView.isEditing
           ? UIImage(systemName: "checkmark")
           : UIImage(systemName: "pencil")
   }
}

extension UITableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(data[indexPath.row])")
        tableView.deselectRow(at: indexPath, animated: true)
        let photoGalleryVC = PhotoGalleryViewController()
        navigationController?.pushViewController(photoGalleryVC, animated: true)
    }
}


extension UITableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        let dataCell = data[indexPath.row]
        cell.configure(image: UIImage(systemName: "apple.meditate")!, title: "\(dataCell.0)", subtitle: "\(dataCell.1)")
        return cell
    }
    
    // Editing possibility
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Move possibility
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = data.remove(at: sourceIndexPath.row)
        data.insert(movedItem, at: destinationIndexPath.row)
    }
}
