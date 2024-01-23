<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <title>MIRE MOVIE</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .dropdown:hover .dropdown-menu {
            display: block;
            margin-top: 0;
        }

        .nav-link {
            color: white;
        }

        .table th,
        .table td {
            text-align: left;
        }

        .table th {
            width: 20%;
        }

        .table td {
            width: 80%;
        }

        .table td:nth-child(2) {
            width: 100%; /* 수정된 부분: 100%로 조절 */
        }
    </style>
</head>

<body>
    <!-- 헤더 -->
    <header>
        <%@ include file="../WEB-INF/header.jsp"%>
    </header>
    <!-- 메인 -->
    <main class="container">
        <div class="container mt-3">
            <h2>영화관 세부정보</h2>
            <a href="/cinema/cinemalist.jsp"><button class="btn btn-dark mb-2">영화관 리스트 목록</button></a>
            <a href="/cinema/cinemamodify.jsp">
				<button class="btn btn-dark mb-2">영화관 수정</button></a>
            <table class="table table-bordered table-striped">
                <tbody id="tableBody">
                </tbody>
            </table>
        </div>
    </main>
    <!-- 푸터-->
    <footer class="container">
        <%@ include file="../WEB-INF/footer.jsp"%>
    </footer>

    <script>
        $(document).ready(function () {
            var cinemaNo = sessionStorage.getItem('CinemaNo');

            $.ajax({
                type: 'GET',
                url: '/cinema/' + cinemaNo,
                contentType: 'application/json',
                success: function (cinema) {
                    appendCinemaToTable(cinema);
                },
                error: function (error) {
                    var errorMessage = error.responseText;
                    alert(errorMessage);
                }
            });
        });

        function appendCinemaToTable(cinema) {
            var tbody = $("#tableBody");
            tbody.empty();

            var row = "<tr><th scope='col'>영화관 번호</th><td>"
                + cinema.cinemaNo
                + "</td></tr>"
                + "<tr><th scope='col'>영화관 이름</th><td>"
                + cinema.cinemaName
                + "</td></tr>"
                + "<tr><th scope='col'>영화관 소개</th><td style='height: 200px;'><img src='../upload/5002009-09-14-001.jpg'>"
                + cinema.cinemaIntro
                + "</td></tr>"
                + "<tr><th scope='col'>총 상영관 수</th><td>"
                + cinema.cinemaTotalScreen
                + "</td></tr>"
                + "<tr><th scope='col'>영화관 전화번호</th><td>"
                + cinema.cinemaPhone
                + "</td></tr>"
                + "<tr><th scope='col'>영화관 위치</th><td>"
                + cinema.cinemaLocation
                + "</td></tr>";
            tbody.append(row);
        }
    </script>
</body>

</html>
