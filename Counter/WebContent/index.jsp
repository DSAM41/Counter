<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<title>index</title>

<style>
<%@include file="/WEB-INF/css/css_table_test.css"%>
</style>

<!-- CSS -->
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<!-- AJAX -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- MODAL -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>
<!-- VALIDATE -->
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.min.js"></script>


<script>

GetUser();

function btnEdit() {
    $('.editbtn').on('click', function () {
        $('#editmodal').modal('show');
        $tr = $(this).closest('tr');;
        var data = $tr.children("td").map(function () {
            return $(this).text();
        }).get();
        console.log("editbtn");
        $('#hopo').val(data[0]);
        $('#flti').val(data[1]);
        $('#alc2').val(data[2]);
        $('#counter').val(data[3]);
        $('#hopo_old').val(data[0]);
        $('#flti_old').val(data[1]);
        $('#alc2_old').val(data[2]);
        $('#counter_old').val(data[3]);
    });
}

function btnDelete() {
    $('.deletebtn').on('click', function () {
    	var c = confirm("Do you want to delete?");
		if (c == true) {
	        $tr = $(this).closest('tr');
	        var data = $tr.children("td").map(function () {
	            return $(this).text();
	        }).get();     
	        var hopo = data[0]; 
	        var flti = data[1]; 
	        var alc2 = data[2]; 
	        $.ajax({
				type: "GET",
				url:"Delete_data",
				data:{"hopo":hopo, "flti":flti, "alc2":alc2},
				success: function (data) {
					console.log("delete");
				 GetUser()
				}
			});     
		}                 
	});
}


$(document).ready(function() {
    $('.createbtn').on('click', function () {
		$('#createmodal').modal('show');
		console.log("createbtn");
    });
});

function GetUser(){	
	$.ajax({
		type: "GET",
		url:"Get_data",
		success: function (data) {
			console.log("Get_data");
			var obj = jQuery.parseJSON(data);
			if(obj != '') {
				$("#myBody").empty();
				$.each(obj, function(key, val) {
					var tr = "<tr>";
					tr = tr + "<td>" + val["hopo"] + "</td>";
					tr = tr + "<td>" + val["flti"] + "</td>";
					tr = tr + "<td>" + val["alc2"] + "</td>";
					tr = tr + "<td>" + val["counter"] + "</td>";
					tr = tr + '<td><button type="button" class="btn btn-primary editbtn">EDIT</button></td>';
					tr = tr + '<td><button type="button" class="btn btn-danger deletebtn">DELETE</button></td>';
					tr = tr + "</tr>";
					$('#customers > tbody:last').append(tr);
				});
			}
		}
	}); 
	setTimeout(btnEdit, 1000); 
	setTimeout(btnDelete, 1000);
}


$(document).ready(function() {
    $("#form_create").validate({
		errorClass: 'errors',
        rules: {
        	create_hopo: "required",
        	create_flti: "required",
        	create_alc2: "required",
        	create_counter: "required"
        },
        messages: {
        	create_hopo: "Please specify HOPO.",
        	create_flti: "Please specify FLTI.",
        	create_alc2: "Please specify ALC2.",
        	create_counter: "Please specify COUNTER."
        }
    });
    $('#create').click(function() {
        var n = $("#form_create").valid();
        console.log("valid update");
    });
});

$(document).ready(function() {
    $("#form_edit").validate({
    	errorClass: 'errors',
        rules: {
        	counter: "required"
        },
        messages: {
        	counter: "Please specify COUNTER."
        }
    })
    $('#update').click(function() {
        var n = $("#form_edit").valid();
        console.log("valid update");
    });
});

$(document).ready(function(){
	$('#update').click(function(){ 
		var hopo=$('#hopo').val();
		var flti=$('#flti').val();
		var alc2=$('#alc2').val();
   		var counter=$('#counter').val();
   		if (counter!=""){
   	 	    $.ajax({
   				type: "GET",
   				url:"Edit_data",
   	 	     	data:{"hopo":hopo,"flti":flti,"alc2":alc2,"counter":counter},
   	 	 		success: function (data) {
   	 	       		if(data == 1){
   	  	 	          	GetUser();
   	  	 	           	console.log("update"); 
   	  	 	           	$('#editmodal').modal('hide');  
   	  		       	} else {
   	  					alert("duplicate information");
   	  				}
   	 	     	}
   	 		}); 
   	   	}                        
 	});
});

$(document).ready(function(){
	$('#create').click(function(){   
		var hopo=$('#create_hopo').val();
		var flti=$('#create_flti').val();
		var alc2=$('#create_alc2').val();
		var counter=$('#create_counter').val();
   		if (counter!="" || alc2!=""){
	 		$.ajax({
	 			type: "GET",
	 			url:"Create_data",
	 			data:{"hopo":hopo,"flti":flti,"alc2":alc2,"counter":counter},
	 			success: function (data) {
	 	 			if(data == 1){
			 			GetUser();
			 	 	 	console.log("create"); 
			 	 	 	$('#createmodal').modal('hide');  
	 	 	 	  	} else {
	 	 	 	 	  	alert("duplicate information");
					}  	 
				}
	 		});   
   		}           
	});
});

$(document).ready(function(){
	$("#search_hopo, #search_flti, #search_alc2, #search_counter").keyup(function(){
		var hopo=$('#search_hopo').val();
		var flti=$('#search_flti').val();
		var alc2=$('#search_alc2').val();
		var counter=$('#search_counter').val();
		if (hopo!="" || flti!="" || alc2!="" || counter!=""){
			$.ajax({
	 			type: "GET",
	 			url:"Get_datasearch",
	 			data:{"hopo":hopo, "flti":flti, "alc2":alc2, "counter":counter},
	 			success: function (data) {
	 				var obj = jQuery.parseJSON(data);
	 				if(obj != '') {
	 					$("#myBody").empty();
	 					$.each(obj, function(key, val) {
	 						var tr = "<tr>";
	 						tr = tr + "<td>" + val["hopo"] + "</td>";
	 						tr = tr + "<td>" + val["flti"] + "</td>";
	 						tr = tr + "<td>" + val["alc2"] + "</td>";
	 						tr = tr + "<td>" + val["counter"] + "</td>";
	 						tr = tr + '<td><button type="button" class="btn btn-primary  editbtn">EDIT</button></td>';
	 						tr = tr + '<td><button type="button" class="btn btn-danger deletebtn">DELETE</button></td>';
	 						tr = tr + "</tr>";
	 						$('#customers > tbody:last').append(tr);
	 					});
	 				}	 
				}
	 		});   
		} else {
			GetUser();
		}
		console.log("search"); 
		setTimeout(btnEdit, 1000); 
		setTimeout(btnDelete, 1000);
	});
});

</script>
</head>
<body>
	<div class="container mt-2 pb-2 border ">
		<h1>Counter Information</h1>
<!-- 		<div class="text-right"> -->
<!-- 			<button type="button" class="btn btn-primary my-1 createbtn">CREATE</button> -->
<!-- 		</div> -->
		<div>
		<table id="customers">
			<thead>
				<tr>
					<th>
	  					<input type="text" class="form-control" id="search_hopo" placeholder="Search HOPO" style="text-transform:uppercase">
	  				</th>
					<th>
	  					<input type="text" class="form-control" id="search_flti" placeholder="Search FLTI" style="text-transform:uppercase">
	  				</th>
					<th>
	  					<input type="text" class="form-control" id="search_alc2" placeholder="Search ALC2" style="text-transform:uppercase">
	  				</th>
					<th>
	  					<input type="text" class="form-control" id="search_counter" placeholder="Search COUNTER" style="text-transform:uppercase">
	  				</th>
	  				<th colspan="2">
	  					<button type="button" class="btn btn-info my-1 btn-block createbtn">CREATE</button>
  					</th>
				</tr>
				<tr>
					<th>HOPO</th>
					<th>FLTI</th>
					<th>ALC2</th>
					<th>COUNTER</th>
					<th>EDIT</th>
					<th>DELETE</th>
				</tr>
				</thead>
				<tbody id="myBody">	
				</tbody>
		</table>
	</div>
</div>
	<!-- EDIT POP UP FORM (Bootstrap MODAL) -->
    <div class="modal fade" id="editmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"> Edit Data </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <form id="form_edit" name="form_edit">

                    <div class="modal-body">

                        <input type="hidden" name="update_id" id="update_id">

                        <div class="form-group">
                            <label> HOPO </label>
                            <input type="text" name="hopo" id="hopo" class="form-control"
                                placeholder="Enter HOPO" maxlength="3" disabled="disabled">
                        </div>

                        <div class="form-group">
                            <label> FLTI </label>
                            <input type="text" name="flti" id="flti" class="form-control"
                                placeholder="Enter FLTI" maxlength="1" disabled="disabled">
                        </div>

                        <div class="form-group">
                            <label> ALC2 </label>
                            <input type="text" name="alc2" id="alc2" class="form-control"
                                placeholder="Enter ALC2" maxlength="2" disabled="disabled">
                        </div>
                        
                        <div class="form-group">
                            <label> COUNTER </label>
                            <input type="text" name="counter" id="counter" class="form-control"
                                placeholder="Enter COUNTER" maxlength="14" style="text-transform:uppercase">
                        </div>
                       
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" id="update" name="updatedata" class="btn btn-primary">Update Data</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
    
    <!-- CREATE POP UP FORM (Bootstrap MODAL) -->
    <div class="modal fade" id="createmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"> Create Data </h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <form id="form_create" name="form_create">

                    <div class="modal-body">


						<div class="form-group">
						    <label> HOPO </label>
						    <select class="form-control" id="create_hopo">
						      <option>BKK</option>
						      <option>CNX</option>
						      <option>CET</option>
						      <option>DMK</option>
						      <option>HKT</option>
						      <option>HDY</option>
						    </select>
						  </div>


						<div class="form-group">
						    <label> FLTI </label>
						    <select class="form-control" id="create_flti">
						      <option>I</option>
						      <option>D</option>
						    </select>
						  </div>

                        <div class="form-group">
                            <label> ALC2 </label>
                            <input type="text" name="create_alc2" id="create_alc2" class="form-control"
                                placeholder="Enter ALC2" maxlength="2" style="text-transform:uppercase">
                        </div>
                        
                        <div class="form-group">
                            <label> COUNTER </label>
                            <input type="text" name="create_counter" id="create_counter" class="form-control"
                                placeholder="Enter COUNTER" maxlength="14" style="text-transform:uppercase">
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="button" id="create" name="createdata" class="btn btn-primary">Create Data</button>
                    </div>
                </form>

            </div>
        </div>
    </div>
</body>
</html>



<!-- <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script> -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script> -->
