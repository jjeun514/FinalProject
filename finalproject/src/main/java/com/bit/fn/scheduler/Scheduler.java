package com.bit.fn.scheduler;

import java.awt.List;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.mail.MessagingException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

import com.bit.fn.model.service.MailService;
import com.bit.fn.model.service.MemberService;
import com.bit.fn.model.service.MemberinfoService;
import com.bit.fn.model.service.ReservationService;
import com.bit.fn.model.vo.MemberInfoVo;
import com.bit.fn.model.vo.ReservationVo;

@Component
public class Scheduler {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private MemberinfoService memberinfoService;
	
	@Autowired
	MailService mailService;
	
	
	
	
//	@Scheduled(fixedDelay = 3000)
//	public void test() {
//		
//	}
	
	
	
	@Scheduled(cron = "0 30 7-23 * * MON-FRI")
	//@Scheduled(fixedDelay = 3000)
	public void reservationReminder() {

		// 현재 날짜 생성
		SimpleDateFormat convertDate = new SimpleDateFormat("yyyy-MM-dd HH");
		String today = convertDate.format(new Date());
		int now = Integer.parseInt(today.substring(11));

		// 회의실 예약 정보 조회
		java.util.List<ReservationVo> reservationList = service.searchAllReservation();
		
		/*
		 * for문에서 사이즈를 구하는 메소드는 실행시키지 않게 짜는 것이 좋음
		 * 변수명은 한눈에 알아볼 수 있도록 작성할 것
		 * 리스트에 조회된 값이 없을 때 오류 처리
		 * integer 파싱할 때도 값이 없을 때 오류 처리
		 * 세세한 부분을 신경쓰기
		 */
		
		//if ( reservationList.size() == 0 ) { return; }
		
		int allReservationSize = reservationList.size();
		for ( int i = 0; i < allReservationSize ; i++ ) {
			// 전체 예약 내역에서 사용 시간을 가져오고
			String reservationTime = reservationList.get(i).getUseStartTime();
			int convertTime = Integer.parseInt(reservationTime.substring(11));
			int calculateTime = convertTime-now;
			
			if ( ( calculateTime ) == 1 ) {
				MemberInfoVo member = memberinfoService.searchUserByMemNum(reservationList.get(i).getMemNum());
				
				String id = member.getId();
				int roomNum = reservationList.get(i).getRoomNum();
				String memName = member.getMemName();
				String useStartTime = reservationTime;
				
				try {
					mailService.sendRemindReservation(id, roomNum, memName, useStartTime);
				} catch (MessagingException e) {
					e.printStackTrace();
				}
			
			}
		}
		
	}
	
	public void sendRemindReservationMail(String id, int roomNum, String memName, String useStartTime) throws MessagingException {
		mailService.sendRemindReservation(id, roomNum, memName, useStartTime);
	}
	
}
