<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MyBatis 게시판 - 영화관 수정</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
   <header>
      <%@ include file="../WEB-INF/header.jsp"%>
   </header>
   <div class="container mt-5">
      <div class="row justify-content-center">
         <div class="col-md-6">
            <h1 class="text-center mb-4">영화관 수정</h1>
            <form>
               <div class="form-group">
                  <label for="cinemaNo">영화관번호</label>
                  <input type="text" class="form-control" id="cinemaNo" readonly>
               </div>
               <div class="form-group">
                  <label for="cinemaName">영화관이름</label>
                  <input type="text" class="form-control" id="cinemaName">
               </div>
               <div class="form-group">
                  <label for="cinemaIntro">영화관소개</label>
                  <textarea class="form-control" id="cinemaIntro" style="height: 200px;"></textarea>
               </div>
               <div class="form-group">
                  <label for="cinemaTotalScreen">총상영관수</label>
                  <input type="text" class="form-control" id="cinemaTotalScreen">
               </div>
               <div class="form-group">
                  <label for="cinemaPhone">영화관전화번호</label>
                  <input type="text" class="form-control" id="cinemaPhone">
               </div>
               <div class="form-group">
                  <label for="cinemaLocation">영화관위치</label>
                  <textarea class="form-control" id="cinemaLocation" style="height: 200px;"></textarea>
               </div>
               <div class="d-flex justify-content-center">
                  <div class="text-center">
                     <button class="btn btn-light bg-dark text-light" type="button" onclick="updateInfo()">수정하기</button>
                     <!-- You can add a button for deletion if needed -->
                  </div>
                  <div class="text-center">
                     <a href="/cinema/list.jsp">
                        <button class="btn btn-light bg-dark text-light" type="button">목록으로</button>
                     </a>
                  </div>
               </div>
            </form>
         </div>
      </div>
   </div>
   <footer class="text-dark">
      <%@ include file="../WEB-INF/footer.jsp"%>
   </footer>

 <script type="text/javascript">
		$(document)
				.ready(
						function() {
							// 페이지 로드 시 sessionStorage에서 선택한 상품 정보를 가져와서 폼에 표시
							var cinema = sessionStorage.getItem('cinema');
							if (cinema) {
								cinema = JSON.parse(cinema);
								$('#cinemaNo').val(cinema.cinemaNo);
								$('#cinemaName').val(cinema.cinemaName);
								$('#cinemaIntro').val(cinema.cinemaIntro);
								$('#cinemaTotalScreen').val(cinema.cinemaTotalScreen);
								$('#cinemaPhone').val(cinema.cinemaPhone);
								$('#cinemaLocation').val(cinema.cinemaLocation);
							} else {
								console.error('No selected item information found in sessionStorage.');
							}
						});

		function updateInfo() {
			var cinemaNo = $("#cinemaNo").val();
			var cinemaName = $("#cinemaName").val();
			var cinemaIntro = $("#cinemaIntro").val();
			var cinemaTotalScreen = $("#cinemaTotalScreen").val();
			var cinemaPhone = $("#cinemaPhone").val();
			var cinemaLocation = $("#cinemaLocation").val();

			// 사용자에게 현재 입력된 값들을 보여줌
			var confirmationMessage = "영화 이름: " + cinemaName + "\n" + "영화 소개: "
					+ cinemaIntro + "\n" + "영화관 총 상영관수: " + cinemaTotalScreen + "\n" + "영화관 전화번호: "
					+ cinemaPhone + "\n" + "영화관 위치: " + cinemaLocation + "\n\n"
					+ "입력된 정보로 수정하시겠습니까?";

			var confirmUpdate = confirm(confirmationMessage);

			if (confirmUpdate) {
				var data = {
						cinemaName : cinemaName,
						cinemaIntro : cinemaIntro,
						cinemaTotalScreen : cinemaTotalScreen,
						cinemaPhone : cinemaPhone,
						cinemaLocation : cinemaLocation,
				};

				$.ajax({
					type : "PUT",
					url : "/cinema",
					contentType : "application/json; charset=UTF-8",
					data : JSON.stringify(data),
					success : function(response) {
						console.log("수정 성공:", response);
						alert("영화관이 수정되었습니다.");
						 // 수정 후 로컬 스토리지에서 선택한 상품 정보 삭제
		                localStorage.removeItem('cinema');
						location.href = "/cinema/list.jsp";
					},
					error : function(error) {
						var errorMessage = error.responseText;
						alert(errorMessage);
					}
				});
			} else {
				// 사용자가 수정을 취소한 경우
				alert("수정이 취소되었습니다.");
			}
		}

		
	</script>

	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
   
</body>
</html>
