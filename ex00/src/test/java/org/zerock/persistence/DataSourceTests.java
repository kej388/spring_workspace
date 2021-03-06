package org.zerock.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.mapper.TimeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class DataSourceTests {

//	@Setter(onMethod_ = { @Autowired })
//		private DataSource dataSource;
//		@Test
//		public void testConnection() {
//			try (Connection con = dataSource.getConnection()) {
//				log.info(con);
//			} catch(Exception e) {
//				fail(e.getMessage());
//			}
//		}
	
	@Setter(onMethod_ = @Autowired) 
	private TimeMapper timeMapper;
	
	@Test
	public void testGetTime2() {
		log.info("getTime2");
		log.info(timeMapper.getTime2());
	}
	
	
	// oracle 연결 테스트
//	static {
//		try {
//			Class.forName("oracle.jdbc.driver.OracleDriver");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//	
//	@Test
//	public void testConnection() {
//		try (Connection con = 
//				DriverManager.getConnection(
//						"jdbc:oracle:this:@lacalhost:1521:XE",
//						"ora_user",
//						"hong")) {
//			log.info(con);
//		} catch(Exception e) {
//			fail(e.getMessage());
//		}
//	}
	
}
