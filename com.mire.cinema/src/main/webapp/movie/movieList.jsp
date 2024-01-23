<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<meta charset="UTF-8">
<title>MIRE MOVIE</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/common.css">
<style>
        /* Add some spacing and styling to the movie cards */
        .movie-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-evenly;
        }

        .movie-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            margin: 10px;
            width: 250px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
            background-color: #fff;
            overflow: hidden;
        }

        .movie-card:hover {
            transform: scale(1.05);
        }

        .movie-card img {
            max-width: 100%;
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .movie-card .movie-info {
            padding: 10px;
        }

        .movie-card h4 {
            margin: 10px 0;
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .movie-card p {
            margin: 0;
            font-size: 14px;
            color: #777;
        }

        .movie-card button {
            margin-top: 10px;
        }

        /* Style pagination buttons */
        #paging {
            margin-top: 20px;
        }

        #prev>button,
        #next>button,
        #pageNum>button {
            border: 1px solid #ddd;
            background-color: #f9f9f9;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s ease-in-out;
        }

        #prev>button:hover,
        #next>button:hover,
        #pageNum>button:hover {
            background-color: #ddd;
        }

        #pageNum>button:active {
            color: red;
        }
    </style>


</head>

<body>
	<header>
		<%@ include file="../WEB-INF/header.jsp"%>
	</header>

	<div class="container">
		<div class="tab">
			<p>영화목록</p>
		

			<div class="movie-container d-flex justify-content-between"
				id="movieContainer">
				<!-- Data will be appended here using JavaScript -->
			</div>

			<div id="paging" class="d-flex container justify-content-center mt-5">
				<div id="prev" class="mx-4"></div>
				<div id="pageNum"></div>
				<div id="next" class="mx-4"></div>
			</div>
		</div>
	</div>

	<footer class="py-3 my-4">
		<%@ include file="../WEB-INF/footer.jsp"%>
	</footer>


</body>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
        document.addEventListener('DOMContentLoaded', function () {
            fetchMovies(1); // Initial fetch with page 1
        });

        function fetchMovies(pageNum) {
            fetch('/movie/list/' + pageNum, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                },
            })
                .then(response => {
                    if (!response.ok) {
                        return response.json().then(errorData => {
                            alert("서버내부 오류: " + errorData.message);
                            throw new Error('Server error');
                        });
                    }
                    return response.json();
                })
                .then(data => {
              
                    let movies = data.list;
                    let paginationData = data.page;
                    createPaginationButtons(paginationData.beginPage, paginationData.endPage, paginationData.prev, paginationData.next);
                    displayMovies(movies);
     
                })
                .catch(error => {
                    console.error('Fetch error:', error.message);
                });
        }

        function displayMovies(movies) {
        

            $('#movieContainer').empty();
			
          
            for (var movie of movies) {
   				console.log(movie.movieDate);
   				console.log(movie.imageUuid);
            
   				let movieCard = 
   				    '<div class="movie-card" onclick="getMovie(' + movie.movieNo + ')" style="cursor:pointer; display: flex; flex-direction: column;">' +
   				        '<img src="../upload/' + movie.imageUuid + '">' +
   				        '<div class="d-flex align-items-center ">' + 
   				            '<div class="p-2 rounded bg-dark" style="font-size: 17px; color:white;">' + movie.movieLimit + '</div>' +
   				            '<h4>제목:' + movie.movieTitle + '</h4>' +
   				        '</div>' +
   				        '<div style="font-size: 16px;">개봉일: ' + movie.movieDate + '</div>' +
   				        '<button class="btn btn-secondary mt-auto" onclick="reserveMovie(' + movie.movieNo + ')">예매</button>' +
   				    '</div>';
   				$('#movieContainer').append(movieCard);
            }
            
        }
        function createPaginationButtons(begin, end, prev, next) {
            let prevPage = begin - 1;
            let nextPage = end + 1
            $('#prev').html(prev ? '<button onclick="fetchMovies(' + prevPage + ')">이전</button>' : '');
            $('#next').html(next ? '<button onclick="fetchMovies(' + nextPage + ')">다음</button>' : '');

            $('#pageNum').empty();
            for (let i = begin; i <= end; i++) {
                $('#pageNum').append('<button onclick="fetchMovies(' + i + ')" class="mx-2">' + i + '</button>');
            }
        };
        function getMovie(movieNo){
        	console.log(movieNo);
        	localStorage.setItem('movieNo',movieNo);
        	location.href = '/movie/movieInfo.jsp';
        };
        
                                                                                                                                                         
    </script>


</html>