<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>jQuery UI Autocomplete - Default functionality</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>

 $(function() {

 //autocomplete 대상의 value가 변경되면 프로세스에 사용할 변수를 초기화한다.(재검색시 해당 변수에 값을 다시 넣기위함)

 $("#autocompleteUserName").change(function(){
     selectedUser = "";
     $("#userId").val("");
 });
    //input의 id를 autocomplete한다.
    $( "#autocompleteUserName").autocomplete({
     source : function(request, response){
      $.ajax({
          type:"post",
          dataType:"json",                  //data를 json으로 return 받음.
          url:"/autoComplete",          //json으로 데이터를 반환해야한다.
          data:{"userName":$("#autocompleteUserName").val()},
          success:function(data){
           response($.map(data.userList, function(item){     //function의 item에 data가 바인딩된다.
            return{
            //기본적으로 label과 value를 사용하지만 custom 변수를 선언해서 사용 가능하다. ui.item.변수명으로 사용가능함.
            //data는 반환한 배열, data[i].USER_INFO 및 아래 선언된 KEY값이 들어가있다.

             label: "[" + item.id + "]" + item.name,
             value: "[" + item.id + "]" + item.name,
             userId:item.id,
             userName:item.name//,
             //deptName:item.DEPT_NAME,
             //positionName:item.POSITION_NAME
            }
           }));
          },

          error: function(jqxhr, status, error){
               alert(jqxhr.statusText + ",  " + status + ",   " + error);
               alert(jqxhr.status);
               alert(jqxhr.responseText);
          }
         })

     },

     autoFocus:true,             //첫번째 값을 자동 focus한다.
     matchContains:true,
     minLength:1,               //1글자 이상 입력해야 autocomplete이 작동한다.
     delay:100,                 //milliseconds
     select:function(event,ui){         //ui에는 선택된 item이 들어가있다.(custom 변수 포함)
      $("#userId").val(ui.item.userId);
      selectedUser = ui.item.label;      

      //fn_regist()가 중복실행되서 처리함.
      var flag = false;
      $("#autocompleteUserName").keydown(function(e){   //엔터키를 통해 등록 script를 실행(선택시의 enter와는 별개로 작동한다.)
       if(e.keyCode == 13){
        if(!flag){
          fn_regist();    //등록 함수(선택한 후 엔터키 입력시 실행될 function)
          flag = true;
        }
       }
      });
     },

     focus:function(event, ui){return false;} //한글입력시 포커스이동하면 서제스트가 삭제되므로 focus처리

    });

  });

 function search() {
	 var userName = document.getElementById("autocompleteUserName").value;
	 
	 if(localStorage.getItem('test') != null) {
	     localStorage.setItem('test', userName);
	 } else {
		 localStorage.setItem('test', localStorage.getItem('test') + ',' +  userName);
	 }
 }
 
 function delete() {
	 localStorage.clear();
 }
  </script>
</head>
<body>
 
<form name="form1" action="" method="post">
<input type="hidden" id="userId" name="userId" />
</form>

<div class="ui-widget">
  <label for="tags">User</label>
  <input type="text" id="autocompleteUserName" name="autocompleteUserName" size="40"> <!-- //지정된 input box의 size만큼 autocomplete사이즈 자동변경 -->
  <input type="button" value="Search" onclick="search()" />
  <input type="button" value="Delete" onclick="delete()" />
</div>
 
</body>
</html>