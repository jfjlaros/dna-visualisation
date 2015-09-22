import sandy.core.Scene3D;
import sandy.core.scenegraph.Camera3D;
import sandy.core.scenegraph.Group;
import sandy.core.scenegraph.Node;
import sandy.core.scenegraph.TransformGroup;
import sandy.core.data.Point3D;
import sandy.core.scenegraph.Sprite2D;
import sandy.primitive.Line3D;
import sandy.materials.Appearance;
import sandy.materials.WireFrameMaterial;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.Lib;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLLoader;
import flash.events.Event;
import flash.events.KeyboardEvent;

class DNAvis extends Sprite {
  var scene:Scene3D;
  var globe:TransformGroup;
  var cx:Float;
  var cy:Float;
  var cz:Float;
  var loader:URLLoader;
  var inputText:TextField;
  var inputText2:TextField;
  var inputText3:TextField;
  var doRot:Bool;
  var oldMouseX:Float;
  var oldMouseY:Float;

  public function new() { 
    super(); 
    scene = new Scene3D("myScene", this, 
                        new Camera3D(600, 500, 1, 0, 100000), 
                        new Group("root"));
    scene.camera.y = 15000; 
    scene.camera.lookAt(0, 0, 0);

    reload();
    var fakeButton:TextField = new TextField();
    fakeButton.width = 20;
    fakeButton.height = 20;
    fakeButton.x = 0;
    fakeButton.y = 0;
    fakeButton.text= "Go";
    fakeButton.border= true;
    fakeButton.selectable = false;
    this.addChild(fakeButton);

    var normText = new TextField();
    normText.width = 55;
    normText.height = 20;
    normText.x = 25;
    normText.y = 0;
    normText.text = "Offset:";
    normText.selectable = false;
    this.addChild(normText);

    inputText = new TextField();
    inputText.width = 55;
    inputText.height = 20;
    inputText.x = 65;
    inputText.y = 0;
    inputText.text = "40375";
    inputText.type = INPUT;
    inputText.selectable = true;
    inputText.maxChars = 7;
    inputText.border = true;
    this.addChild(inputText);

    var normText2 = new TextField();
    normText2.width = 55;
    normText2.height = 20;
    normText2.x = 125;
    normText2.y = 0;
    normText2.text = "Length:";
    normText2.selectable = false;
    this.addChild(normText2);

    inputText2 = new TextField();
    inputText2.width = 45;
    inputText2.height = 20;
    inputText2.x = 170;
    inputText2.y = 0;
    inputText2.text = "750";
    inputText2.type = INPUT;
    inputText2.selectable = true;
    inputText2.maxChars = 5;
    inputText2.border = true;
    this.addChild(inputText2);

    var normText3 = new TextField();
    normText3.width = 55;
    normText3.height = 20;
    normText3.x = 220;
    normText3.y = 0;
    normText3.text = "Step:";
    normText3.selectable = false;
    this.addChild(normText3);

    inputText3 = new TextField();
    inputText3.width = 30;
    inputText3.height = 20;
    inputText3.x = 250;
    inputText3.y = 0;
    inputText3.text = "3";
    inputText3.type = INPUT;
    inputText3.selectable = true;
    inputText3.maxChars = 3;
    inputText3.border = true;
    this.addChild(inputText3);
    submit(null);
  }

  function reload():Void {

    globe = new TransformGroup();
    scene.root.addChild(globe);

    addLabel( 30,  30,  30, "A");
    addLabel(-30, -30,  30, "C");
    addLabel(-30,  30, -30, "G");
    addLabel( 30, -30, -30, "T");
    cx = 0;
    cy = 0;
    cz = 0;
    addCLine(0xff0000, 0, 0, 0,  30,  30,  30);
    addCLine(0xff0000, 0, 0, 0, -30, -30,  30);
    addCLine(0xff0000, 0, 0, 0, -30,  30, -30);
    addCLine(0xff0000, 0, 0, 0,  30, -30, -30);

    //submit(null);

    rotateGlobe(null);
    Lib.current.stage.addEventListener(MouseEvent.MOUSE_MOVE, rotateGlobe);
    Lib.current.stage.addEventListener(MouseEvent.MOUSE_DOWN, enableRot);
    Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, disableRot);
    Lib.current.stage.addEventListener(MouseEvent.CLICK, submit); 
    Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, zoom); 
    Lib.current.stage.addChild(this);
    scene.render();
  }

  function zoom(event:KeyboardEvent):Void {
    switch(event.keyCode) {
      case 38:
        if (scene.camera.y > 1500) {
          scene.camera.y -= 1500;
        }
      case 40:
        scene.camera.y += 1500;
    }
    scene.camera.lookAt(0, 0, 0);
    scene.render();
  }

  function rotateGlobe(e:MouseEvent):Void {
    if (doRot) {
      //globe.rotateY += Lib.current.stage.mouseX - oldMouseX; 
      globe.rotateZ += -1 * (Lib.current.stage.mouseX - oldMouseX); 
      globe.rotateX += -1 * (Lib.current.stage.mouseY - oldMouseY); 
      scene.render();
    }
    oldMouseX = Lib.current.stage.mouseX;
    oldMouseY = Lib.current.stage.mouseY;
  }

  function enableRot(e:MouseEvent):Void {
    doRot = true;
  }

  function disableRot(e:MouseEvent):Void {
    doRot = false;
  }

  function addLine(x0:Float, y0:Float, z0:Float, 
                   x1:Float, y1:Float, z1:Float):Void {
    var myLine:Line3D = new Line3D("aLine", 
                                   [new Point3D(x0 - cx, y0 - cy, z0 - cz), 
                                    new Point3D(x1 - cx, y1 - cy, z1 - cz)]);
    globe.addChild(myLine);
  }

  function addCLine(color:Int, x0:Float, y0:Float, z0:Float, 
                               x1:Float, y1:Float, z1:Float):Void {
    var myLine:Line3D = new Line3D("cLine", 
                                   [new Point3D(x0 - cx, y0 - cy, z0 - cz), 
                                    new Point3D(x1 - cx, y1 - cy, z1 - cz)]);
    var material:WireFrameMaterial = new WireFrameMaterial(1, color);
    var app:Appearance = new Appearance(material);

    myLine.appearance = app;
    globe.addChild(myLine);
  }

  function addLabel(x:Float, y:Float, z:Float, l:String):Void {
    var label:Sprite2D;
    var tf:TextField = new TextField();
    var myBitmapData:BitmapData = new BitmapData(30, 30, true, 0);
    var bmp:Bitmap;

    tf.text = l;
    myBitmapData.draw(tf);

    bmp = new Bitmap(myBitmapData);
    label = new Sprite2D(l, bmp, .7);
    label.x = x;
    label.y = y;
    label.z = z;
    globe.addChild(label);
  }

  function submit(e:MouseEvent):Void {
    if ((Lib.current.stage.mouseX < 20) && (Lib.current.stage.mouseY < 20)) {
      globe.getChildByName("A").destroy();
      globe.getChildByName("C").destroy();
      globe.getChildByName("G").destroy();
      globe.getChildByName("T").destroy();
      globe.destroy();
      reload();
      var text = inputText.getRawText();
      var text2 = inputText2.getRawText();
      var text3 = inputText3.getRawText();
      var request:URLRequest = 
        new URLRequest("http://www.liacs.nl/~jlaros/projects/dnavis/select.cgi?" + 
                       text + "&" + text2 + "&" + text3);

      request.method = URLRequestMethod.GET;
      loader = new URLLoader();
      loader.addEventListener(Event.COMPLETE, loadComplete);
      loader.load(request);
    }
  }

  function loadComplete(e:Event):Void {
    var array = loader.data.split(" ");
    var x, y, z, oldx, oldy, oldz;

    cx = array.splice(array.len - 3, 1);
    cy = array.splice(array.len - 2, 1);
    cz = array.splice(array.len - 1, 1);

    oldx = array.shift();
    oldy = array.shift();
    oldz = array.shift();
    while (array.length - 3 > 0) {
      x = array.shift();
      y = array.shift();
      z = array.shift();
      addLine(oldx, oldy, oldz, x, y, z);
      oldx = x;
      oldy = y;
      oldz = z;
    }  
    dispatchEvent(e);
    scene.render();
  }

  static function main() {
    new DNAvis();
  }
}
