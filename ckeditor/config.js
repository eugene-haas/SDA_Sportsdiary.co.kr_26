/**
 * @license Copyright (c) 2003-2017, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	config.toolbarGroups = [
		{ name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
		{ name: 'editing', groups: [ 'find', 'selection', 'spellchecker', 'editing' ] },
		{ name: 'links', groups: [ 'links' ] },
		{ name: 'insert', groups: [ 'insert' ] },
		{ name: 'forms', groups: [ 'forms' ] },
		{ name: 'tools', groups: [ 'tools' ] },
		{ name: 'document', groups: [ 'mode', 'document', 'doctools' ] },
		{ name: 'others', groups: [ 'others' ] },
		{ name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
		{ name: 'paragraph', groups: [ 'list', 'indent', 'blocks', 'align', 'bidi', 'paragraph' ] },
		{ name: 'styles', groups: [ 'styles' ] },
		{ name: 'colors', groups: [ 'colors' ] },
		{ name: 'about', groups: [ 'about' ] }
	];

	config.removeButtons = 'Underline,Scayt,Maximize,Strike,PasteFromWord,PasteText,Paste';
	config.removeButtons = 'Underline,Scayt,Maximize,Strike,PasteText,Paste,Anchor,SpecialChar,Subscript,Superscript,RemoveFormat,PasteFromWord';
	//config.removeButtons = 'Underline,Subscript,Superscript,Scayt,Maximize,RemoveFormat,Strike,PasteFromWord,PasteText,Paste,Source';

	config.extraPlugins = 'pastefromexcel';

	//config.language = 'kr';
	config.uiColor = '#F7B42C';
	config.height = 550;
	//config.toolbarCanCollapse = false;
};




