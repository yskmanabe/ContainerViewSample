//
//  ListScene.swift
//  ContainerViewSample
//
//  Created by Ysk.Manabe on 2022/12/31.
//

import UIKit

class ListScene: UIViewController {
    
    @IBOutlet weak var animatedSwitch: UISwitch!
    @IBOutlet weak var layoutStyleSegment: LayoutStyleSegmentControl!

    private var dataSource = [DataSource]() {
        didSet {
            self.embededDelegate?.reloadData()
        }
    }

    private var embededDelegate: ListSceneEmbededDelegate? {
        return self.embededScene as? ListSceneEmbededDelegate
    }

    private var embededScene: UIViewController? {
        return self.children.first { viewController in
            return viewController is ListSceneEmbededDelegate
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reload()
    }

    private func reload() {
        Task {
            self.dataSource = try await self.fetchData()
        }
    }


    private func fetchData() async throws -> [DataSource] {
        let result = Task.detached {
            let data = [
                DataSource(title: "えんぴつ",
                           image: UIImage(systemName: "pencil")!),
                DataSource(title: "けしごむ",
                           image: UIImage(systemName: "eraser")!),
            ]
            return data
        }
        return await result.value
    }

    private func setupViews() {
        self.embed(with: self.layoutStyleSegment.style)
    }
    

    private func embed(with style: LayoutStyleSegmentControl.Style) {
        switch style {
        case .table:
            UIEmbedSegue.embed(self.createTableLayoutScene(), to: self)
        case .grid:
            UIEmbedSegue.embed(self.createGridLayoutScene(), to: self)
        }
    }

    @IBAction func layoutStyleDidChange(_ sender: LayoutStyleSegmentControl) {

        guard let fromVC = self.embededScene else {
            self.embed(with: sender.style)
            return
        }

        switch sender.style {
        case .table:
            Self.transition(source: fromVC,
                            destination: self.createTableLayoutScene(),
                            animated: self.animatedSwitch.isOn)
        case .grid:
            Self.transition(source: fromVC,
                            destination: self.createGridLayoutScene(),
                            animated: self.animatedSwitch.isOn)
        }

    }

    private func createTableLayoutScene() -> TableLayoutScene {
        let scene = UIStoryboard(name: "TableLayoutScene", bundle: nil).instantiateInitialViewController() as! TableLayoutScene
        scene.dataSource = self
        return scene
    }

    private func createGridLayoutScene() -> GridLayoutScene {
        let scene = UIStoryboard(name: "GridLayoutScene", bundle: nil).instantiateInitialViewController() as! GridLayoutScene
        scene.dataSource = self
        return scene
    }

}

extension ListScene {

    class DataSource: TableLayoutSceneDataSource, GridLayoutSceneDataSource {

        var title: String = ""

        var image: UIImage = UIImage(systemName: "square.split.diagonal.2x2")!

        init(title: String, image: UIImage) {
            self.title = title
            self.image = image
        }
    }

}

protocol ListSceneEmbededDelegate {

    func reloadData()
}

extension ListScene: TableLayoytSceneDataSource, GridLayoytSceneDataSource {
    
    var numberOfRows: Int {
        self.dataSource.count
    }
    
    
    func dataSourceforRow(at index: Int) -> TableLayoutSceneDataSource {
        return self.dataSource[index]
    }
    
    
    func dataSourceforCell(at index: Int) -> GridLayoutSceneDataSource {
        return self.dataSource[index]
    }

}

extension ListScene {

    static func transition(source: UIViewController, destination: UIViewController, animated: Bool) {

        let segue: UIEmbedSegue = {
            if animated {
                return SampleCumstomEmbedSegue(source: source,
                                               destination: destination)
            } else {
                return UIEmbedSegue(source: source,
                                    destination: destination)
            }
        }()

        segue.perform()
    }
}
