### JSP-Project

##게시판 만들기 프로젝트
- 다른 기능과의 차별적인것만 기술해 두었습니다. 상세 코드는 깃에 업로드 시켜 두었습니다.

#MVC2방식을 이용한 게시판 만들기

<pre>
<code>
public interface ClsController {
	String exec(HttpServletRequest req, HttpServletResponse resp);
}
</code>
</pre>


#글 리스트 컨트롤러
<pre>
<code>
public class Board implements ClsController {

	@Override
	public String exec(HttpServletRequest req, HttpServletResponse resp) {
		String view = "/board/board.jsp";
/		// 페이징 처리
		int nowPage = 1;
		String strPage = req.getParameter("nowPage");
//		System.out.println("NowPage : " + strPage);
		try {
			nowPage = Integer.parseInt(strPage);
			
		}catch(Exception e) {
		}
		BoardDAO bDAO = new BoardDAO();
		int totalCount = bDAO.getTotal();
		PageUtil page = new PageUtil(nowPage, totalCount, 10, 3);
		ArrayList<BoardVO> list = bDAO.getAllList(page);
		// 데이터 뷰에 심고
		req.setAttribute("LIST", list);
		req.setAttribute("PAGE", page);
		
		return view;
	}

}
</code>
</pre>

#글 검색 DAO
<pre>
<code>
public ArrayList<BoardVO> searching(String condition, String input, PageUtil page ) {
		ArrayList<BoardVO> slist = new ArrayList<BoardVO>();
		
		con = db.getCon();
		String sql = bSQL.getSQL(bSQL.SEARCH);
		// 검색 타입은 replaceAll 함수를 사용
		if (condition.equals("bdtt")) {
			sql = sql.replaceAll("#", "bdtt");
			
		} else if (condition.equals("bdbd")){
			sql = sql.replaceAll("#", "bdbd");
			
		} else if (condition.equals("name")){
			sql = sql.replaceAll("#", "name");
		}
		pstmt = db.getPSTMT(con, sql);
		try {
			
      // 검색어는 받아서 처리
			pstmt.setString(1, input);
//			System.out.println(condition +",");
			pstmt.setInt(2, page.getStartCont());
			pstmt.setInt(3, page.getEndCont());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardVO bVO = new BoardVO();
				// 데이터 뽑고 VO에 담기
				bVO.setBdno(rs.getInt("bdno"));
				bVO.setBdct(rs.getString("bdct"));
				bVO.setBdtt(rs.getString("bdtt"));
				bVO.setName(rs.getString("name"));
				bVO.setbDate(rs.getDate("today"));
				bVO.setbTime(rs.getTime("today"));
				bVO.setSdate();
				bVO.setVcnt(rs.getInt("vcnt"));
				
				slist.add(bVO);
				System.out.println("요기리스트사이즈" + slist.size());
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			db.close(rs);
			db.close(stmt);
			db.close(con);
		}
		return slist;
	}
  
  </code>
</pre>

#카테고리 질의명령
<pre>
<code>

  SELECT
			rno, bdno, bdct, bdtt, name, today, vcnt
	FROM 
	  (SELECT
        ROWNUM rno, bdno, bdct, bdtt, name, today, vcnt
     FROM( SELECT
              bdno, bdct, bdtt, name, today, vcnt
          FROM
		          board b, member m
	        WHERE
              bdct = ? AND b.memno = m.memno AND
              b.bdshow = 'Y' AND
              bdct != '댓글'
          ORDER BY
              bdno DESC
              )
             )
    WHERE
      rno BETWEEN ? AND ?
  </code>
</pre>
