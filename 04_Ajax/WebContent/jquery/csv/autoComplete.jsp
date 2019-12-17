<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ajax::jquery::autoComplete</title>
<style>
div.wrapper{position: relative;}
ul#autoComplete{background-color: white; min-width: 159px; border: 1px solid gray; position: absolute; top: 22px; padding:0; margin:0;}
ul#autoComplete li{padding:0 10px; list-style:none; cursor:pointer;}
ul#autoComplete li.sel{background:lightseagreen; color:white;}
span.srchval{color:red;}
</style>
<script src="<%=request.getContextPath()%>/jquery/jquery-3.4.1.js"></script>
<script>
$(function(){
    
    var $autoComplete = $("#autoComplete");
    $autoComplete.hide(); // 페이지 최초 로딩시 조회결과 ul태그는 안보임 처리한다
    
    $("#srchName").on('keyup', function(e){
        // 방향키 제어 ArrowDown, ArrowUp, Enter
        console.log(e.key);
        
        var $sel = $(".sel");
        var $li = $autoComplete.children("li");
        
        
        if(e.key == 'ArrowDown'){
            
            if($sel.length == 0){
                $li.first().addClass("sel");
            }
            else{
                $sel.removeClass("sel")
                	.next()
                	.addClass("sel");
            }
        }
        else if(e.key == 'ArrowUp'){
            if($sel.length != 0){
                $sel.removeClass("sel")
                	.prev()
                	.addClass("sel");
            }
            else{
                $li.last().addClass("sel");
            }
        }
        else if(e.key == 'Enter'){
            $(this).val($sel.text());
            $autoComplete.hide()
            			 .children()
            			 .remove();
        }
        else{
            
            var srchNameVal = $(this).val().trim();
                
            //공백 입력시 ajax요청 보내지 않음.
            if(srchNameVal.length == 0) return;
            
            $.ajax({
                url: "<%=request.getContextPath()%>/jquery/autoComplete",
                type: "post",
                //data: "srchName="+srchNameVal,
                data: {srchName: srchNameVal},//객체로 전달해도 jquery가 직렬화처리
                success: function(data){
                    console.log(data);
                    //조회된 결과가 없는경우
                    if(data.trim().length==0){
                        
                    }
                    // 조회결과가 있는 경우
                    else{
                        var dataArr = data.split(',');
                        var html = "";
                        $.each(dataArr, (idx, val)=>{
                            // html += "<li>" + val + "</li>";
                            html += "<li>" + val.replace(srchNameVal, '<span class="srchval">'+ srchNameVal + '</span>') + "</li>"
                        });
                         $autoComplete.html(html).fadeIn(300);
                        
                    }
                },
                error: function(jqxhr, textStatus, errorThrown){
                    console.log("ajax처리실패!", jqxhr, textStatus, errorThrown);
                }
            });
                
        } // end of Ajax
        
        //이벤트버블링(자식 => 부모)을 이용한 처리
        //요소를 선택한 경우
        $autoComplete.on('click', 'li', e => {
        	//화살표함수 내에서 this는 무조건 window
            $("#srchName").val($(e.target).text());
            $autoComplete.hide()
            			 .children()
            			 .remove();
        }).on('mouseover','li', e=>{
        	$(e.target).addClass("sel")
        			   .siblings()
        			   .removeClass("sel");
        	
        }).on('mouseout','li', e=>{
        	$(e.target).removeClass("sel");
        });
   });
});
</script>
</head>
<body>
    <h1>ajax::jquery::autoComplete</h1>
    <h2>친구 검색</h2>
    <div class="wrapper">
        <input type="text" id="srchName" />
        
        <ul id="autoComplete"></ul>
    </div>
</body>
</html>