package com.mire.cinema.service;



import java.util.List;
import java.util.Map;

import com.mire.cinema.domain.movie.Movie;
import com.mire.cinema.domain.movie.MovieDTO;

public interface MovieService {
	
	public void saveMovie(Movie movie);
	public Movie findMovie(int movieNo);
	public void modifyMovie(Movie movie);
	public void removeMovie(int movieNo);
	public int getTotalCount();
	public List<Movie> getTotalList();
	public List<MovieDTO.Movies> getPartList(int start, int end);
	public Map<String,Object> getPageMap(Integer pageNum);
}
