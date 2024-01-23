<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>문의 작성</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
    rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
.form-container {
    margin-top: 50px;
}
</style>
</head>
<body>
    <header>
        <%@ include file="../WEB-INF/header.jsp"%>
    </header>
    <div class="container">
        <h2 class="mt-3">문의사항</h2>
        <div class="form-container">
            <form id="ask" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="askTitle" class="form-label">제목</label> <input
                        type="text" class="form-control" id="askTitle"
                        placeholder="제목을 입력해주세요" required>
                </div>
                <div class="mb-3">
                    <label for="askContent" class="form-label">문의사항</label>
                    <textarea class="form-control" id="askContent"
                        placeholder="문의사항을 입력해주세요" required></textarea>
                </div>
                <div class="mb-3">
                    <label for="askImage" class="form-label">이미지</label> <input
                        type="file" class="form-control" id="askImage"
                        placeholder="업로드할 이미지를 삽입해주세요" required>
                </div>
                <button type="button" class="btn btn-primary"
                    onclick="writeAsk()">작성하기</button>
            </form> 
        </div>
    </div>
    <footer class="container">
        <%@ include file="../WEB-INF/footer.jsp"%>
    </footer>
</body>

<script>
function writeAsk() {
    var askTitle = $('#askTitle').val();
    var askContent = $('#askContent').val();
    var fileInput = $('#askImage')[0].files[0];

    var formData = new FormData();
    formData.append('askTitle', askTitle);
    formData.append('askContent', askContent);

    // 세션에서 memberId 가져오기
    var memberId = '<%= session.getAttribute("memberId") %>';
    formData.append('memberId', memberId);

    if (fileInput) {
        formData.append('file', fileInput);
    }

    console.log(formData); // formData 로그 확인

    $.ajax({
        type: 'POST',
        url: '/ask',
        contentType: false,
        processData: false,
        data: formData,
        success: function (response) {
            console.log(response); // 응답 로그 확인
            alert(response);
            location.href = "/ask/asklist.jsp";
        },
        error: function (error) {
            console.error(error); // 오류 로그 확인
            var errorMessage = error.responseText;
            alert("로그인이 필요한 서비스입니다.");
        }
    });
}

</script>
</html>
