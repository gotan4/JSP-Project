/**
 * @author 이진수
 * 
 */
package com.team.www.controller.board;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.team.www.controller.ClsController;
import com.team.www.dao.BoardDAO;
import com.team.www.util.PageUtil;
import com.team.www.vo.BoardVO;

public class BoardCate implements ClsController {

	@Override
	public String exec(HttpServletRequest req, HttpServletResponse resp) {
		String view = "/board/cboard.jsp";

		int nowPage = 1;
		String strPage = req.getParameter("nowPage");
		try {
			nowPage = Integer.parseInt(strPage);
		// 형변환
		} catch (Exception e) {
		}
		//페이징처리를 하기위한 현제페이지 출력
	
		BoardDAO bDAO = new BoardDAO();
		String cate = req.getParameter("tab");
		// jsp 카테고리를 tab에 담아서 전송받음
		
		int totalCount = bDAO.getCTotal(cate);
		// 카테고리별 게시글 수를 구하여 페이징 하기위한 토탈값
		
		PageUtil page = new PageUtil(nowPage, totalCount, 10, 3);
		ArrayList<BoardVO> clist = bDAO.getCateList(cate, page);
		// 카테고리별 리스트 구하여 clist에 담고

		req.setAttribute("LIST", clist);
		req.setAttribute("PAGE", page);
		req.setAttribute("CAT", cate);
		// 화면에 심고

		return view;
		// view를 부르고
	}

}
