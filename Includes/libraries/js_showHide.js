var state = 'hidden';

function showhide(layer_ref) {

if (state == 'visible') {
state = 'hidden';
}
else {
state = 'visible';
}
if (document.all) { //IS IE 4 or 5 (or 6 beta)
eval( "document.all." + layer_ref + ".style.visibility = state");
}
if (document.layers) { //IS NETSCAPE 4 or below
document.layers[layer_ref].visibility = state;
}
if (document.getElementById && !document.all) {
maxwell_smart = document.getElementById(layer_ref);
maxwell_smart.style.visibility = state;
}
}