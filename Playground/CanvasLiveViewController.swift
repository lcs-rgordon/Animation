import Cocoa

open class CanvasLiveViewController: NSViewController {
    
    var canvas : Canvas
    
    public init(with canvas : Canvas) {

        // Give this controller a connection to the canvas being drawn upon
        self.canvas = canvas

        // Initialize the superclass
        super.init(nibName: nil, bundle: nil)
        
        // Make the canvas be the view of this controller
        self.view = self.canvas
        
    }
    
    override open func loadView() {
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewWillAppear() {
    }
    
}
