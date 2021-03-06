import com.haxepunk.Entity;
import com.haxepunk.graphics.Tilemap;
import com.haxepunk.HXP;
import com.haxepunk.masks.Grid;
import com.haxepunk.Scene;
import haxe.xml.Fast;
import openfl.Assets;

class MainScene extends Scene
{
	
	//helper vars for loading .oel level
	private var xml:Xml;
	private var fastXml:Fast;
	
	override public function begin()
	{
		
		loadlevel("levels/level1.oel");
		
	}
	
	public function loadlevel(level:String):Void 
	{
		
		//get the XML
		xml = Xml.parse(Assets.getText(level));
		fastXml = new haxe.xml.Fast(xml.firstElement());
		
		//create new Tilemap and add it to the Scene
		var tilemap:Tilemap = new Tilemap("graphics/tileset.png", Std.parseInt(fastXml.att.width), Std.parseInt(fastXml.att.height), 32, 32);
		add(new Entity(0, 0, tilemap));
		
		//add Tiles
		tilemap.loadFromString(fastXml.node.TileLayer.innerData, ",", "\n");
		
		//add Entities to the Scene
		for (p in fastXml.node.EntityLayer.nodes.Player)
		{
			add(new Player(Std.parseInt(p.att.x), Std.parseInt(p.att.y)));
		}
		
		//load collision grid and add it to Scene
		var grid:Grid = new Grid(Std.parseInt(fastXml.att.width), Std.parseInt(fastXml.att.height), 32, 32);
		grid.loadFromString(fastXml.node.Grid.innerData, "", "\n");
		addMask(grid, "solid");
		
		
	}
}