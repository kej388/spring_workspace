package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;

public interface BoardMapper {
	// 목록 
	public List<BoardVO> getList();
	
	// 등록
	public void insert(BoardVO board);
	
	// 등록번호
	public void insertSelectKey(BoardVO board);
	
	// 조회
	public BoardVO read(Long bno);
}
