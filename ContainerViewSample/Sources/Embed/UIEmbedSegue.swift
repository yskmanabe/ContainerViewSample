//
//  UIEmbedSegue.swift
//  ContainerViewSample
//
//  Created by Ysk.Manabe on 2023/01/14.
//

import UIKit

@MainActor open class UIEmbedSegue {

    /// 遷移元
    public let source: UIViewController

    /// 遷移先
    public let destination: UIViewController

    /// エンベッド先
    public var container: UIViewController?

    public init(source: UIViewController, destination: UIViewController) {
        self.source = source
        self.destination = destination
        self.container = source.parent
    }

    open func perform() {
        guard let container = self.container else {
            return
        }

        Self.unEmbed(source)
        Self.embed(destination,
                               to: container)
    }

}

extension UIEmbedSegue {

    // Memo
    // addChild(_:) メソッドをコールした直後に、 子ビューコントローラの didMove(toParent:) メソッドをコールしなければなりません。
    // カスタムコンテナが addChild(_:) メソッドをコールすると、 自動的に子として追加されるビューコントローラの willMove(toParent:) メソッドをコールしてから子として追加されます。
    static func embed(_ viewController: UIViewController, to container: UIViewController) {
        container.addChild(viewController)
        viewController.view.frame = container.view.bounds
        container.view.addSubview(viewController.view)
        viewController.didMove(toParent: container)
    }

    // Memo
    // removeFromParent()メソッドをコールする前に子ビューコントローラの willMove(toParent:) メソッドをコールし、 親の値として nil を渡さなければなりません。
    // removeFromParent() メソッドは、 子を削除した後に子ビューコントローラの didMove(toParent:) メソッドを自動的にコールします。
    static func unEmbed(_ viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

}
