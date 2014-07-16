(function(){
'use strict';

// document.getElementsByTagName('body')[0].addEventListener('submit', function (e){
// 	e.preventDefault();
// });

function appendTask(){
	getElementsByClassName
};

window.onload = function() {
$.get('/api/list', function (result){
	var data = JSON.parse(result);
	var table = document.getElementsByClassName('display')[0];
	var row;
	var cell1;
	var cell2;
	var form;
	var checkbox;
	var hidden;

	for (var i = 0; i < data.length; i++) {
		form = document.createElement('form');
		form.action = "/del";
		form.method = "POST";
		hidden = document.createElement('input');
		hidden.name = "frombeta";
		hidden.type = "hidden";
		checkbox = document.createElement('input');
		checkbox.name = "chk";
		checkbox.type = "checkbox";
		checkbox.setAttribute('onclick', 'this.form.submit();');
		form.appendChild(checkbox);
		form.appendChild(hidden);
		row = table.insertRow(i);
		checkbox.value = data[i];
		cell1 = row.insertCell(0);
		cell1.appendChild(form);
		cell2 = row.insertCell(1);
		cell2.innerText = data[i];
	};
});
};

})(window)