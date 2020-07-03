package org.zerock.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.zerock.domain.BoardAttachVO;
import org.zerock.mapper.BoardAttachMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Component
@AllArgsConstructor
public class FileCheckTask {
	
	private BoardAttachMapper attachmapper;
	
	private String getFolderYesterDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		
		cal.add(Calendar.DATE, -1);
		
		String str = sdf.format(cal.getTime());
		
		return str.replace("-", File.separator);
	}
	
	@Scheduled(cron = "0 * * * * *")
	public void checkFiles() throws Exception{
		log.warn("File Check Task run...........");
		
		log.warn("==============================");
		
		List<BoardAttachVO> fileList = attachmapper.getOldFiles();
		
		List<Path> fileListPaths = fileList.stream().map(vo -> Paths.get("c:\\upload", vo.getUploadPath(),
				vo.getUuid() + '_' + vo.getFileName())).collect(Collectors.toList());
	}
	
	
}
