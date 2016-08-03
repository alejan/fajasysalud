// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap


$(document).on('ready',function(){
	
	// previene duplicados de jquery_ujs
	var pms='';
	 
	// maneja seleccion de todos los checkbox
	
	$(this).on('click',function(){
		var pg=window.location.href;
		pg=pg.substring(-1);
		console.log(pg);
		window.onpopstate= (function(){
			
				window.location.reload();
				
			
		});
		
		$("#id").change(function(){
			
			if($(this).is(":checked")){
				$(":checkbox:gt(0)").prop("checked",true);
			
			}else{
				$(":checkbox:gt(0)").prop("checked",false);
				pms='';
			}
			
			});
		
	// evita averlay de shadows en bootstrap modals	
		
		$('div.modal-backdrop.fade.in:gt(0)').remove();
		
	});
	
	pms=$('.pms').attr('href')+"?";
	 
	$('.pms').click(function(){
		
		$(':checkbox:gt(0)').each(function(){
			
				if($(this).is(':checked')){
					
					pms+="id[]="+$(this).attr('name')+'&';
					
					
						$('.pms').attr('href',pms);
						
				}
			
		});
		
		
		
	});
	
	$('#mostrar').change(function(){
		console.log(window.location.href);
	});

});

function rLoad(){
	window.location.reload();
}

// cambia orientacion de chevron en menus

function chevronToggle(id){

  var chevron=document.getElementById(id).className;

  var optRight1="glyphicon glyphicon-chevron-right";
  var optRight2="glyphicon glyphicon-chevron-right collapsed";

  if(chevron==optRight1 | chevron==optRight2){
    document.getElementById(id).className="glyphicon glyphicon-chevron-down";

  }else{
    document.getElementById(id).className="glyphicon glyphicon-chevron-right";
  }

}
function goAnt(param){
	var p=param.href;
	var q=param.href;
	q=q.slice(0,-1);
	
	p=p.substring(p.length-1,p.length);
	p=(parseInt(p)-1)<0? 0 : parseInt(p)-1 ;
	param.href=q+=p;
	rLoad();
}
function goSig(param){
	var lsig=document.getElementById('sig').getAttribute('data-value');
	var p=param.href;
	
	var q=param.href;
	
	q=q.slice(0,-1);
	
	p=p.substring(p.length-1,p.length);
	
	p=(parseInt(p)+1)>=lsig? parseInt(p) : parseInt(p)+1 ;
	param.href=q+=p;
	rLoad();
}