package com.bit.fn.controller;

import java.security.Principal;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.fn.model.service.CommentService;
import com.bit.fn.model.service.MemberService;
import com.bit.fn.model.service.MemberinfoService;
import com.bit.fn.model.vo.BoardVo;
import com.bit.fn.model.vo.CommentVo;
import com.bit.fn.model.vo.NoticeVo;
import com.bit.fn.model.vo.PaginationVo;

@Controller
public class MemberController {

	@Autowired
	private MemberService service;
	
	@Autowired
	private CommentService commentService;
	
	@Autowired
	private MemberinfoService memberinfoService;
	
	
	
	// 멤버 파트 인트로 페이지
	@RequestMapping("/intro")
	public String intro() {
		return "memberIntro";
	}
	
	
	
	// 멤버 파트 게시판 인트로 페이지
	@RequestMapping("/board")
	public String bbs(Model model, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "countPerPage", required = false, defaultValue = "10") int countPerPage,
            @RequestParam(value = "pageSize", required = false, defaultValue = "7") int pageSize,
            Principal  principal) {
		
		// 페이징 처리를 위한 셋팅
		int listCount = service.countBoardList();
        PaginationVo pagination = new PaginationVo(currentPage, countPerPage, pageSize);
        pagination.setTotalRecordCount(listCount);
        pagination.calculation();
		
		// 게시판에 보여줄 게시글 불러오기
		List<PaginationVo> boardList = service.memberBoardPaginationList(pagination);
		List<NoticeVo> selectNotice = service.selectNoticeList();
		
		// 페이징 값 보내기
		model.addAttribute("pagination", pagination);
		
		// 모델 객체에 리스트 담아서 뷰로 전달
		model.addAttribute("boardList", boardList);
		model.addAttribute("NoticeList", selectNotice);
		
		//아이디
		String id = principal.getName();
		
		//권한 여부
		int admin=principal.toString().indexOf("ROLE_ADMIN");
		int master=principal.toString().indexOf("ROLE_MASTER");
		int member=principal.toString().indexOf("ROLE_MEMBER");
		
		//여기서 중점! 권한 여부에 따라 불러오는 테이블 값을 다르게 줄 수 있다!
		if( member != -1 ) {
			System.out.println("접속하신 계정은 멤버입니다.");
			System.out.println(memberinfoService.selectOne(id).getMemNum());
			model.addAttribute("member",memberinfoService.selectOne(id));
			
		} 
		
		return "memberBoard";
	}
	
	
	
	// 멤버 파트 게시판 디테일
	@RequestMapping(value = "/board/detail", method = RequestMethod.GET)
	public String boardDetail(Model model, @RequestParam(value = "selectNum") int selectNum) {
		
		BoardVo detail = service.selectOneContent(selectNum);
		
		model.addAttribute("detail", detail);
		
		return "memberBoardDetail";
	}
	
	
	
	// 멤버 파트 게시판 댓글 리스트
	@RequestMapping(value = "/board/detail/comment")
	@ResponseBody
    public ResponseEntity allComment(Model model, Principal  principal, @RequestParam(value = "num") int num) {
        
		//아이디
		String id = principal.getName();
		
		//권한 여부
		int admin=principal.toString().indexOf("ROLE_ADMIN");
		int master=principal.toString().indexOf("ROLE_MASTER");
		int member=principal.toString().indexOf("ROLE_MEMBER");
		
		//여기서 중점! 권한 여부에 따라 불러오는 테이블 값을 다르게 줄 수 있다!
		if( member != -1 ) {
			model.addAttribute("member",memberinfoService.selectOne(id));
		}
		
		// 데이터 담을 객체 생성
		List<Map<String, String>> dataList = new ArrayList<Map<String,String>>();
		java.util.Date from = new java.util.Date();
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		// 모든 코멘트 출력
		List<CommentVo> comment = commentService.allComment(num);
		
		for ( CommentVo content : comment ) {
			Map<String, String> data = new HashMap<String, String>();
			data.put("commentNum", Integer.toString(content.getCommentNum()));
			data.put("num", Integer.toString(content.getNum()));
			data.put("commentWriter", content.getCommentWriter());
			data.put("commentContent", content.getCommentContent());
			data.put("commentDate", transFormat.format(content.getCommentDate()));
			dataList.add(data);
		}
		
		// 담겨진 리스트를 뷰로 전달
		Map<String, Object> commentData = new HashMap<String, Object>();
		commentData.put("commetData", dataList);
		
		return ResponseEntity.ok().build().ok(commentData);
    }
	
	
//	
//	// 멤버 파트 게시판 댓글 작성
//	@RequestMapping(value = "/board/insertComment")
//	public String insertComment(Model model, Principal  principal, @RequestParam String contentWriter, @RequestParam int num, @RequestParam String commentContent) {
//		
//		//아이디
//		String id = principal.getName();
//		
//		//권한 여부
//		int admin=principal.toString().indexOf("ROLE_ADMIN");
//		int master=principal.toString().indexOf("ROLE_MASTER");
//		int member=principal.toString().indexOf("ROLE_MEMBER");
//		
//		//여기서 중점! 권한 여부에 따라 불러오는 테이블 값을 다르게 줄 수 있다!
//		if( member != -1 ) {
//			model.addAttribute("member",memberinfoService.selectOne(id));
//		} else {
//			return "redirect:/intro";
//		}
//		
//		CommentVo comment = new CommentVo();
//		comment.setCommentNum(commentService.searchMaxCommentNumber(num)+1);
//		comment.setNum(num);
//		comment.setCommentWriter(contentWriter);
//		comment.setCommentContent(commentContent);
//		int insert = commentService.insertComment(comment);
//		
//		return "";
//	}
//	
//	
//	
//	// 멤버 파트 게시판 댓글 수정
//	@RequestMapping(value = "/board/updateComment")
//	public String updateComment(Model model, Principal  principal, @RequestParam int commentNum, @RequestParam String content) {
//		
//		//아이디
//		String id = principal.getName();
//		
//		//권한 여부
//		int admin=principal.toString().indexOf("ROLE_ADMIN");
//		int master=principal.toString().indexOf("ROLE_MASTER");
//		int member=principal.toString().indexOf("ROLE_MEMBER");
//		
//		//여기서 중점! 권한 여부에 따라 불러오는 테이블 값을 다르게 줄 수 있다!
//		if( member != -1 ) {
//			model.addAttribute("member",memberinfoService.selectOne(id));
//		} else {
//			return "redirect:/intro";
//		}
//		
//		CommentVo comment = new CommentVo();
//		comment.setCommentNum(commentNum);
//		comment.setCommentContent(content);
//		int update = commentService.updateComment(comment);
//		
//		return "";
//		
//	}
//	
//	
//	
//	// 멤버 파트 게시판 댓글 삭제
//	@RequestMapping(value = "/board/deleteComment/{commentNum}")
//	public String deleteComment(Model model, Principal  principal, @RequestParam int commentNum) {
//		
//		//아이디
//		String id = principal.getName();
//		
//		//권한 여부
//		int admin=principal.toString().indexOf("ROLE_ADMIN");
//		int master=principal.toString().indexOf("ROLE_MASTER");
//		int member=principal.toString().indexOf("ROLE_MEMBER");
//		
//		//여기서 중점! 권한 여부에 따라 불러오는 테이블 값을 다르게 줄 수 있다!
//		if( member != -1 ) {
//			model.addAttribute("member",memberinfoService.selectOne(id));
//		} else {
//			return "redirect:/intro";
//		}
//		
//		int delete = commentService.deleteComment(commentNum);
//		
//		return "";
//	}
//
//
//	
	
	private ResponseEntity ResponseEntity(List<CommentVo> allComment, HttpStatus ok) {
		// TODO Auto-generated method stub
		return null;
	}



	// 멤버 파트 공지 게시판 인트로 페이지
	@RequestMapping("/notice")
	public String notice(Model model, HttpServletRequest request,
			@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "countPerPage", required = false, defaultValue = "10") int countPerPage,
            @RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize) {
		
		int listCount = service.countNoticeList();
        PaginationVo pagination = new PaginationVo(currentPage, countPerPage, pageSize);
        pagination.setTotalRecordCount(listCount);
        pagination.calculation();
		
		// 게시판에 보여줄 공지 게시글 불러오기
		List<NoticeVo> noticeList = service.noticeList(pagination);
		
		// 페이징 값 보내기
		model.addAttribute("pagination", pagination);
		
		// 모델 객체에 리스트 담아서 뷰로 전달
		model.addAttribute("noticeList", noticeList);
		
		return "memberNotice";
	}
	
	
	
	// 멤버 파트 공지게시판 디테일
	@RequestMapping(value = "/notice/detail", method = RequestMethod.GET)
	public String noticeDetail(Model model, @RequestParam(value = "selectNum") int selectNum) {
		
		NoticeVo detail = service.selectOneNotice(selectNum);
		
		model.addAttribute("detail", detail);
		
		return "memberNoticeDetail";
	}
	

	
	// 멤버 파트 내 스케쥴 관리 인트로 페이지
	@RequestMapping("/schedule")
	public String schedule() {

		return "memberSchedule";
	}
	
}