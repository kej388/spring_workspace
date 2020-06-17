package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;

public interface BoardMapper {
	// 목록 
	public List<BoardVO> getList();
	
}
