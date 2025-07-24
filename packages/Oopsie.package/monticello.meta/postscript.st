(PackageInfo named: 'Oopsie') postscript: '"below, add code to be run after the loading of this package"
(InspectorField allInstVarNames includes: ''acceptBlock'') ifFalse:
	[InspectorField addInstVarNamed: ''acceptBlock''].'!
