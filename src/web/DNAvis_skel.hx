import sandy.core.Scene3D;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Group;
import sandy.core.scenegraph.TransformGroup;
import sandy.core.data.Point3D;
import sandy.primitive.Line3D;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.Lib;

class DNAvis extends Sprite {
  var scene:Scene3D;
  var globe:TransformGroup;

  public function new() { 
    super(); 
    scene = new Scene3D("myScene", this, new Camera3D(400, 300), 
                                         new Group("root"));
    globe = new TransformGroup();
    scene.camera.y = 200; 
    scene.camera.lookAt(0, 0, 0);
    scene.root.addChild(globe);

    addLine(100, 100, 100, 125, 125, 125);

    rotateGlobe(null);
    Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, rotateGlobe); 
    Lib.current.stage.addChild(this);
  }

  function rotateGlobe (e:MouseEvent):Void {
    globe.rotateY = (Lib.current.stage.mouseX - 275); 
    globe.rotateX = -1 * (Lib.current.stage.mouseY - 275); 
    scene.render();
  }

  function addLine (x0:Float, y0:Float, z0:Float, 
                    x1:Float, y1:Float, z1:Float):Void {
    var myLine:Line3D = new Line3D("aLine", [new Point3D(x0, y0, z0), 
                                             new Point3D(x1, y1, z1)]);
    globe.addChild(myLine);
  }

  static function main() {
    new DNAvis();
  }
}
