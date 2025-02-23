package com.mire.cinema.service;

import com.mire.cinema.domain.screen.Screen;
import com.mire.cinema.domain.screen.ScreenDTO;

import java.util.List;

public interface ScreenService {
	//상영관 등록
	public void saveScreen(Screen screen);
	//상영관 리스트
	public List<Screen> seeScreen();
	//상영관 정보 보기
	public Screen findScreen(long screenNo);
	//영화관 상영관 정보 
	public Screen findCinemaScreen(String cinemaName);
	//상영관 정보 수정
	public void modifyScreen(ScreenDTO.Update screen);
}
