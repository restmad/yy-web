package com.binghz.control.resume;

import java.io.File;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.binghz.service.resume.ResumeService;
import com.binghz.service.user.UserService;
import com.binghz.yy.consts.common.CommonConstant;
import com.binghz.yy.consts.common.HttpState;
import com.binghz.yy.entity.common.resume.ResumeEntity;
import com.binghz.yy.entity.common.user.UserEntity;
import com.binghz.yy.session.entity.SessionEntity;
import com.binghz.yy.session.service.SessionService;
import com.binghz.yy.utils.CSDNUtils;
import com.binghz.yy.utils.JsonMessage;
import com.qiniu.common.QiniuException;

@Controller
@RequestMapping("resume")
public class ResumeControl {

	@Autowired
	private ResumeService resumeService;
	@Autowired
	private SessionService sessionService;
	@Autowired
	private UserService userService;

	@ResponseBody
	@RequestMapping("save/{token}")
	public JsonMessage saveResume(@PathVariable(value = "token") String token,
			String phone, String introduce, String skills, String expectSalary,
			String id, String position) {
		JsonMessage result = new JsonMessage();
		SessionEntity sessionEntity = sessionService.findByToken(token);
		UserEntity userEntity = userService.findByUserName(sessionEntity
				.getUsername());
		ResumeEntity resumeEntity = resumeService.findOne(NumberUtils
				.toLong(id));
		resumeEntity.setCreateDate(new Date());
		resumeEntity.setExpectSalary(expectSalary);
		resumeEntity.setIntroduce(introduce);
		resumeEntity.setUpdateDate(new Date());
		resumeEntity.setPosition(position);
		resumeEntity.setUserId(userEntity.getId());
		resumeEntity.setResumeUrl("");
		resumeEntity.setValid(1);
		resumeService.save(resumeEntity);
		result.fill(HttpState.HTTP_CHANNEL_SUCCESS,
				HttpState.HTTP_CHANNEL_SUCCESS_STR);
		return result;
	}

	@ResponseBody
	@RequestMapping("upload/{id}/{token}")
	public JsonMessage upload(HttpServletRequest request,
			@RequestParam(value = "resume", required = false) MultipartFile file,
			@PathVariable(value = "id") String id,
			@PathVariable(value = "token") String token) {
		JsonMessage result = new JsonMessage();
		ServletContext servletContext = request.getSession()
				.getServletContext();
		SessionEntity sessionEntity = sessionService.findByToken(token);
		UserEntity userEntity = userService.findByUserName(sessionEntity
				.getUsername());
		String path = servletContext.getContextPath()
				+ CommonConstant.RESUME_SAVE_PATH;
		String fileName = file.getOriginalFilename();
		File targetFile = new File(path, fileName);
		if (!targetFile.exists()) {
			targetFile.mkdirs();
		}
		try {
			file.transferTo(targetFile);
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			CSDNUtils.getFtpQiNiu().upFile(targetFile,
					"resume/" + userEntity.getUserName());
		} catch (QiniuException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ResumeEntity resumeEntity = resumeService.findOne(NumberUtils
				.toLong(id));
		resumeEntity.setResumeUrl(CommonConstant.CSDN_MIRRO_LOCATION + "/resume/"
				+ userEntity.getUserName());
		resumeService.save(resumeEntity);
		result.fill(HttpState.HTTP_CHANNEL_SUCCESS,
				HttpState.HTTP_CHANNEL_SUCCESS_STR);
		return result;
	}

}
