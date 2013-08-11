/* Load this script using conditional IE comments if you need to support IE 7 and IE 6. */

window.onload = function() {
	function addIcon(el, entity) {
		var html = el.innerHTML;
		el.innerHTML = '<span style="font-family: \'bubblio\'">' + entity + '</span>' + html;
	}
	var icons = {
			'idroplet' : '&#xe000;',
			'ifolder-open' : '&#xe006;',
			'ifolder' : '&#xe007;',
			'ispinner' : '&#xe00b;',
			'ilock' : '&#xe00c;',
			'iunlocked' : '&#xe00d;',
			'iremove' : '&#xe00f;',
			'icog' : '&#xe010;',
			'icancel-circle' : '&#xe011;',
			'icheckmark-circle' : '&#xe012;',
			'ispam' : '&#xe013;',
			'iclose' : '&#xe014;',
			'icheckmark' : '&#xe015;',
			'icheckmark-2' : '&#xe016;',
			'iminus' : '&#xe017;',
			'iplus' : '&#xe018;',
			'iradio-checked' : '&#xe024;',
			'iradio-unchecked' : '&#xe025;',
			'iheart' : '&#xe026;',
			'iheart-2' : '&#xe027;',
			'icloud' : '&#xe03c;',
			'ibubblio' : '&#xe03d;'
		},
		els = document.getElementsByTagName('*'),
		i, attr, html, c, el;
	for (i = 0; ; i += 1) {
		el = els[i];
		if(!el) {
			break;
		}
		attr = el.getAttribute('data-icon');
		if (attr) {
			addIcon(el, attr);
		}
		c = el.className;
		c = c.match(/i[^\s'"]+/);
		if (c && icons[c[0]]) {
			addIcon(el, icons[c[0]]);
		}
	}
};