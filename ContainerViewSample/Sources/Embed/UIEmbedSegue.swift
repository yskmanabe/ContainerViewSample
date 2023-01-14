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
    public private(set) var parent: UIViewController?
    public let container: UIView?

    public init(source: UIViewController, destination: UIViewController) {
        self.source = source
        self.destination = destination
        self.parent = source.parent
        self.container = source.view.superview
    }

    open func perform() {
        guard let parent = self.parent else {
            return
        }
        
        guard let container = self.container else {
            return
        }

        Self.unEmbed(self.source)
        Self.embed(self.destination,
                   to: parent,
                   container: container)
    }

}

extension UIEmbedSegue {

    // Memo
    // addChild(_:) メソッドをコールした直後に、 子ビューコントローラの didMove(toParent:) メソッドをコールしなければなりません。
    // カスタムコンテナが addChild(_:) メソッドをコールすると、 自動的に子として追加されるビューコントローラの willMove(toParent:) メソッドをコールしてから子として追加されます。
    static func embed(_ viewController: UIViewController, to parent: UIViewController, container: UIView) {
        parent.addChild(viewController)
        viewController.view.frame = container.bounds
        container.addSubview(viewController.view)
        viewController.didMove(toParent: parent)
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
