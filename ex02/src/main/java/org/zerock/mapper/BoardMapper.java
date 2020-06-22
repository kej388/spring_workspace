package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {
	// 목록 
	public List<BoardVO> getList();
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	// 전체글수
	public int getTotalCount(Criteria cri);
	
	// 등록
	public void insert(BoardVO board);
	
	// 등록번호
	public void insertSelectKey(BoardVO board);
	
	// 조회
	public BoardVO read(Long bno);
	
	// 수정
	public int update(BoardVO board);
	
	// 삭제
	public int delete(Long bno);
	
	
}
