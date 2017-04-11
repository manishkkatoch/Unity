import UIKit
import ObjectiveC

//Extend UIView to allow JSEventHandler as a property.
public extension UIView {
    private struct AssociatedKeys {
        static var unityEventHandler = "unityEventHandler"
    }
    public var UnityEventHandler: AnyObject? {
        get {
            guard let handler = objc_getAssociatedObject(self, &AssociatedKeys.unityEventHandler) as AnyObject? else {
                return nil
            }
            return handler
        }
        
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.unityEventHandler, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func getAllSubViews() -> [UIView] {
        var views = Array<UIView>()
        views.append(self)
        for view in self.subviews {
            views.append(contentsOf: view.getAllSubViews())
        }
        return views
    }
}
