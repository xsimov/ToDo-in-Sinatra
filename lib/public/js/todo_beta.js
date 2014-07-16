(function(){
'use strict';

document.getElementById('submit').addEventListener('click', function (e){
	appendTask(e.target.previousElementSibling.value);
});

document.getElementsByTagName('table')[0].addEventListener('click', function (e){
	deleteTask(e.target);
});

function appendTask(value){
	var newTask = document.getElementsByClassName('adder')[0].value;
	$.post('/beta/save/' + value);
	var i = document.getElementsByTagName('table')[0].children.length;
	addRow(i, value);
	document.getElementsByClassName('adder')[0].value = "";
};

window.deleteTask = function(element){
	if (element.nodeName != 'INPUT') return 0;
	var value = element.value;
	$.post('/beta/del/' + value);
	var row = element.parentNode.parentNode;
	row.parentNode.removeChild(row);
};

window.onload = function() {
	$.get('/api/list', function (result){
		var data = JSON.parse(result);
		for (var i = 0; i < data.length; i++) {
			window.addRow(i, data[i]);	
			};
	});
};

window.addRow = function(i, data) {
	var table = document.getElementsByClassName('display')[0];
	var row;
	var cell1;
	var cell2;
	var form;
	var checkbox;
	checkbox = document.createElement('input');
	checkbox.name = 'chk';
	checkbox.type = 'checkbox';
	row = table.insertRow(i);
	checkbox.value = data;
	cell1 = row.insertCell(0);
	cell1.appendChild(checkbox);
	cell2 = row.insertCell(1);
	cell2.innerText = data;
	};
})(window)