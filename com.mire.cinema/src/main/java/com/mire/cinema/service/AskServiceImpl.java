package com.mire.cinema.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mire.cinema.domain.ask.Ask;
import com.mire.cinema.domain.ask.AskDTO;
import com.mire.cinema.domain.page.PageCreate;
import com.mire.cinema.exception.ErrorMsg;
import com.mire.cinema.repository.AskMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class AskServiceImpl implements AskService {
	private final AskMapper askMapper;

	// 문의사항 등록
	@Override
	public void saveAsk(Ask ask) {
		askMapper.insertAsk(ask);
	}

	// 문의사항 출력하기
	@Override
	public List<Ask> seeAsk() {
		return askMapper.selectAsk();
	}

	// 문의사항 내용 출력
	@Override
	public Ask findAsk(long askNo) {
		return askMapper.getAsk(askNo);
	}

	// 문의사항 내용 업데이트
	@Override
	public void modifyAsk(AskDTO.AskUpdate ask) {
		askMapper.updateAsk(ask);
	}

	// 문의사항 내용 삭제
	@Override
	public void removeAsk(Long askNO) {
		askMapper.deleteAsk(askNO);
	}
	
	// 페이징처리 및 검색기능
		@Override
		public Map<String, Object> getAskMap(Integer pageNum, String askTitle) {
			Map<String, Object> map = new HashMap<>();

			PageCreate pc = new PageCreate();

			if (askTitle == null || "".equals(askTitle.trim())) {
				pc = pc.getPage(pageNum, getTotalAsk());
				map.put("list", askMapper.getPartList(pc.getPaging().getStartNum(), pc.getPaging().getEndNum()));
			} else {
				pc = pc.getPage(pageNum, getTotalAsk(askTitle));
				AskDTO.Search askDTO = new AskDTO.Search();
				askDTO.setAskTitle(askTitle);
				askDTO.setStartNum(pc.getPaging().getStartNum());
				askDTO.setEndNum(pc.getPaging().getEndNum());

				map.put("Keyword", askTitle);
				map.put("searchList", askMapper.searchAskList(askDTO));
			}

			map.put("page", pc);

			return map;
		}

		@Override
		public int getTotalAsk() {
			int num = askMapper.countAsk();
			if (num == 0) {// 0이면
				throw new NullPointerException(ErrorMsg.DataNOTFOUND);
			}
			return num;
		}

		@Override
		public int getTotalAsk(String askTitle) {
			if (askTitle == null) {
				return askMapper.countAsk();
			} else {
				return askMapper.countAskTitle(askTitle);
			}
		}

		@Override
		public Ask findSearchAsk(String askTitle) {
			return askMapper.getSearchAsk(askTitle);
		}

}
