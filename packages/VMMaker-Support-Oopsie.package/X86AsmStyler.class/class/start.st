startup/shutdown
start

	| js lowlight light toRanges |
	self flag: #todo. "
	- add installation logic (Metacello + clone js files (or can we serve them from image?) [+ deno installation])
		For now, you have to do it manually:
			https://github.com/LinqLover/yaros
	- preference for directory path
	- implement cleanUp and unload
	- support further processor architectures, rename this class accordingly
	- register ourselves in TextStyler? or a bad idea because we are not always available?"
	
	JsProcess := PipeableOSProcess command: 'deno run --allow-net js/main.js'
		environment: nil
		workingDir: YarosJsServerDirectory
		input: nil
		output: nil
		error: nil
		errorPipelineStream: nil.
	2 seconds wait.
	
	Yaros := YarosServer new
		connector: (YarosWebSocketClientConnector remoteName: 'localhost' clientPort: nil serverPort: 8082);
		yourself.
	Yaros restart.
	
	js := Yaros remoteObjectNamed: #globalThis.
	
	lowlight := js eval: 'import("https://esm.sh/lowlight@3")'.
	light := lowlight createLowlight: lowlight all.
	
	toRanges := js eval: '(root, classMap = {}) => {
	  let offset = 0;
	  const ranges = [];

	  function walk(node) {
	    // Text node: just advance our running offset
	    if (node.type === "text") {
	      offset += node.value.length;
	      return;
	    }

	    // Element node: maybe record a highlight range
	    if (node.type === "element") {
	      // look for an hljs class
	      const classes = node.properties && node.properties.className;
	      const hlClass = Array.isArray(classes)
	        && classes.find((c) => c.startsWith("hljs-"));

	      // determine our semantic type
	      let type = null;
	      if (hlClass) {
	        type = classMap[hlClass] || hlClass.replace(/^hljs-/, "");
	      }

	      // remember where this element''s text will start
	      const start = offset;

	      // descend into children
	      if (Array.isArray(node.children)) {
	        node.children.forEach(walk);
	      }

	      // after children, our offset is at the end
	      const end = offset;
	      if (type && end > start) {
	        ranges.push([start, end, type]);
	      }
	      return;
	    }

	    // fallback: descend if it has children
	    if (Array.isArray(node.children)) {
	      node.children.forEach(walk);
	    }
	  }

	  walk(root);
	  return ranges;
	}'.
	
	CurrentRangesBlock := [:source |
		| tree |
		tree := light highlight: 'armasm' with: source.
		(js JSON stringify: (toRanges value: tree)) parseAsJson].