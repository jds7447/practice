package dao;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import common.DBConnPool;
import dto.Product;

public class ProductDAO extends DBConnPool {
	
	public ProductDAO() {
		super();
	}
	
	//상품 개수
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
 
		String query = "SELECT COUNT(*) FROM product";
		
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch(Exception e) {
			System.out.println("상품 개수 카운트 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	//상품 목록 (페이징)
	public List<Product> selectListPage(Map<String, Object> map) {
		List<Product> board = new Vector<Product>();
		
		String query = "SELECT * FROM ( "
					+ " 	SELECT Tb.*, ROWNUM rNum FROM ( "
					+ "			SELECT * FROM product ";
		
		if(map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%'";
		}
		
		query += "			ORDER BY idx DESC "
				+ "		) Tb"
				+ " ) "
				+ " WHERE rNum BETWEEN ? AND ?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1,  map.get("start").toString());
			psmt.setString(2,  map.get("end").toString());
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				Product dto = new Product();
				
				dto.setProductId(rs.getString(1));   //상품 아이디
				dto.setPname(rs.getString(2));   //상품명
				dto.setUnitPrice(rs.getInt(3));   //상품 가격
				dto.setDescription(rs.getString(4));   //상품 설명
				dto.setManufacturer(rs.getString(5));   //제조사
				dto.setCategory(rs.getString(6));   //상품 분류
				dto.setUnitsInStock(rs.getLong(7));   //재고 수
				dto.setCondition(rs.getString(8));   //신상품 or 중고품 or 재생품
				dto.setOfile(rs.getString(9));   //원본 파일명
				dto.setSfile(rs.getString(10));   //서버 저장 파일명
				dto.setQuantity(rs.getInt(11));   //장바구니에 담은 개수
				dto.setOrderCount(rs.getInt(12));   //주문 횟수
				
				board.add(dto);   //반환할 결과 목록에 게시물 추가
			}
		}
		catch(Exception e) {
			System.out.println("상품 목록 조회(페이징) 중에 예외 발생");
			e.printStackTrace();
		}
		return board;   //목록 반환
	}
	
	//상품 목록
	public List<Product> selectList(Map<String, Object> map) {
		List<Product> bbs = new Vector<Product>();
		
		String query = "SELECT * FROM product ";   //board 테이블에서 모든 행(튜플) 조회
		if(map.get("serchWord") != null) {
			query += " WHERE " + map.get("serchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' ";
		}
//		query += " ORDER BY num DESC ";   //num 컬럼 값 기준으로 내림 차순 정렬하여 조회
		
		try {
			stmt = con.createStatement();   //연결객체로 쿼리문 생성
			rs = stmt.executeQuery(query);   //쿼리 실행
			
			while(rs.next()) {   //쿼리 결과를 순회하며 반복
				Product dto = new Product();
				
				dto.setProductId(rs.getString(1));   //상품 아이디
				dto.setPname(rs.getString(2));   //상품명
				dto.setUnitPrice(rs.getInt(3));   //상품 가격
				dto.setDescription(rs.getString(4));   //상품 설명
				dto.setManufacturer(rs.getString(5));   //제조사
				dto.setCategory(rs.getString(6));   //상품 분류
				dto.setUnitsInStock(rs.getLong(7));   //재고 수
				dto.setCondition(rs.getString(8));   //신상품 or 중고품 or 재생품
				dto.setOfile(rs.getString(9));   //원본 파일명
				dto.setSfile(rs.getString(10));   //서버 저장 파일명
				dto.setQuantity(rs.getInt(11));   //장바구니에 담은 개수
				dto.setOrderCount(rs.getInt(12));   //주문 횟수
				
				bbs.add(dto);   //결과 목록에 저장
			}
		}
		catch(Exception e) {
			System.out.println("상품 목록 조회 중에 예외 발생");
			e.printStackTrace();
		}
		return bbs;
	}
	
	//상품 상세 목록
	public Product selectListById(Map<String, Object> map, String productId) {
		Product dto = new Product();
		
		String query = "SELECT * FROM product ";   //board 테이블에서 모든 행(튜플) 조회
		if(map.get("serchWord") != null) {
			query += " WHERE " + map.get("serchField") + " "
					+ " LIKE '%" + map.get("searchWord") + "%' "
					+ " AND ";
		}
//		query += " ORDER BY num DESC ";   //num 컬럼 값 기준으로 내림 차순 정렬하여 조회
		if(map.get("serchWord") == null) {
			query += " WHERE ";
		}
		query += " productId = '" + productId + "'";
		
		try {
			stmt = con.createStatement();   //연결객체로 쿼리문 생성
			rs = stmt.executeQuery(query);   //쿼리 실행
			rs.next();
			
			dto.setProductId(rs.getString(1));   //상품 아이디
			dto.setPname(rs.getString(2));   //상품명
			dto.setUnitPrice(rs.getInt(3));   //상품 가격
			dto.setDescription(rs.getString(4));   //상품 설명
			dto.setManufacturer(rs.getString(5));   //제조사
			dto.setCategory(rs.getString(6));   //상품 분류
			dto.setUnitsInStock(rs.getLong(7));   //재고 수
			dto.setCondition(rs.getString(8));   //신상품 or 중고품 or 재생품
			dto.setOfile(rs.getString(9));   //원본 파일명
			dto.setSfile(rs.getString(10));   //서버 저장 파일명
			dto.setQuantity(rs.getInt(11));   //장바구니에 담은 개수
			dto.setOrderCount(rs.getInt(12));   //주문 횟수
			

		}
		catch(Exception e) {
			System.out.println("상품 상세 보기 중에 예외 발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	//상품 데이터를 받아 DB에 추가(파일 업로드 지원)
	public int insertProduct(Product dto) {
		int result = 0;   //쿼리결과 확인 초기 값
		try {
			//INSERT 쿼리문 작성 (작성한 게시글의 내용을 테이블에 추가)
			String query = "INSERT INTO product ("
						+ " productId, pname, unitPrice, description, manufacturer, category, unitsInStock, condition, ofile, sfile) "
						+ " VALUES ( "
						+ " ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			
			psmt = con.prepareStatement(query);   //동적 쿼리
		   //전달받은 dto 객체의 데이터를 가져와 쿼리의 ?에 순서대로 추가
			psmt.setString(1, dto.getProductId());
			psmt.setString(2, dto.getPname());
			psmt.setInt(3, dto.getUnitPrice());
			psmt.setString(4, dto.getDescription());
			psmt.setString(5, dto.getManufacturer());
			psmt.setString(6, dto.getCategory());
			psmt.setLong(7, dto.getUnitsInStock());
			psmt.setString(8, dto.getCondition());
			psmt.setString(9, dto.getOfile());
			psmt.setString(10, dto.getSfile());
			
			result = psmt.executeUpdate();   //쿼리 실행
		}
		catch(Exception e) {
			System.out.println("상품 등록 중 예외 발생");
			e.printStackTrace();
		}
		return result;   //DML 적용된 튜플의 개수 반환
	}
	
	//상품 id에 해당하는 상품 데이터를 DB에서 삭제
	public int deleteProduct(String productId) {
		int result = 0;   //쿼리결과 확인 초기 값
		try {
			
			String query = "DELETE FROM product WHERE productId = ?";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, productId);
			
			result = psmt.executeUpdate();   //쿼리 실행
		}
		catch(Exception e) {
			System.out.println("상품 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;   //DML 적용된 튜플의 개수 반환
	}
}