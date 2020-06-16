package org.zerock.mapper;

public interface TimeMapper {
	
	// TimeMapper.xml의 select태그 id와 같은 이름으로 추상메서드 선언
	// Class를 만들지 않아도 자동으로 생성됨. getTime2()가 구현됨.
	public String getTime2();
}
