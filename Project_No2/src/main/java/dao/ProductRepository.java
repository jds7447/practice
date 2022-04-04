//2022-03-07

package dao;

import java.util.ArrayList;

import dto.Product;

public class ProductRepository {
	//통합 저장소 컬렉션 리스트
	private ArrayList<Product> listOfProducts = new ArrayList<Product>();
	
	
	//2022-03-10 추가----------------------------------------------------------
	//저장소를 공용의 인스턴스로 생성하여 사용하는 변수
	private static ProductRepository instance = new ProductRepository();
	//저장소의 공용 인스턴스 가져오는 메소드
	public static ProductRepository getInstance() {
		return instance;
	}
	//2022-03-10 추가 끝--------------------------------------------------------
	
	
	//생성자
	public ProductRepository() {
		//phone 제품 객체 생성하여 각 데이터 저장
		Product phone = new Product("P1234", "iPhone 6s", 800000);
		phone.setDescription("4.7-inch, 1334X750 Renina HD display, " + "8-megapixel iSight Camera");
		phone.setCategory("Smart Phone");
		phone.setManufacturer("Apple");
		phone.setUnitsInStock(1000);
		phone.setCondition("New");
		
		//2022-03-17 추가---------------------------------------------------------------------------
		//저장소의 기본 저장 항목의 이미지 파일명 추가
		phone.setFilename("P1234.png");
		//2022-03-17 추가 끝-------------------------------------------------------------------------
		
		//notebook 제품 객체 생성하여 각 데이터 저장
		Product notebook = new Product("P1235", "LG PC", 1500000);
		notebook.setDescription("13.3-inch, IPS LED display, " + "5rdGeneration Intel Core Processors");
		notebook.setCategory("Notebook");
		notebook.setManufacturer("LG");
		notebook.setUnitsInStock(1000);
		notebook.setCondition("Refurbished");
		
		//2022-03-17 추가---------------------------------------------------------------------------
		//저장소의 기본 저장 항목의 이미지 파일명 추가
		notebook.setFilename("P1235.png");
		//2022-03-17 추가 끝-------------------------------------------------------------------------
		
		//tablet 제품 객체 생성하여 각 데이터 저장
		Product tablet = new Product("P1236", "Galaxy Tab S", 900000);
		tablet.setDescription("212.8*125.6*6.6mm, Super AMOLED display, " + "Octa-Core processor");
		tablet.setCategory("Tablet");
		tablet.setManufacturer("Samsung");
		tablet.setUnitsInStock(1000);
		tablet.setCondition("Old");
		
		//2022-03-17 추가---------------------------------------------------------------------------
		//저장소의 기본 저장 항목의 이미지 파일명 추가
		tablet.setFilename("P1236.png");
		//2022-03-17 추가 끝-------------------------------------------------------------------------
		
		//생성한 각 객체를 통합 저장소 컬렉션 리스트에 저장
		listOfProducts.add(phone);
		listOfProducts.add(notebook);
		listOfProducts.add(tablet);
	}
	
	//통합 저장소에 저장된 모든 데이터를 컬렉션 리스트 통째로 반환하는 메서드
	public ArrayList<Product> getAllProducts() {
		return listOfProducts;
	}
	
	//2022-03-08 추가----------------------------------------------------------
	//상품 상세 정보를 가져오는 메소드를 추가
	public Product getProductById(String productId) {
		Product productById = null;   //반환 값 넣을 변수 생성 및 초기화
		
		//통합 저장소 컬렉션 리스트의 데이터 개수만큼 반복
		for(int i = 0; i < listOfProducts.size(); i++) {
			//검사할 데이터 담을 임시 변수 생성 및 리스트의 i번째 데이터 저장
			Product product = listOfProducts.get(i);
			//저장한 데이터가 비어있지 않고, 해당 데이터의 productId가 비어있지 않고, 해당 데이터의 productId와 전달받은 productId가 같으면
			if(product != null && product.getProductId() != null && product.getProductId().equals(productId)) {
				//반환 값 넣을 변수에 해당 데이터를 저장 후
				productById = product;
				break;   //반복문을 탈출한다
			}   //listOfProducts에 저장된 모든 상품 목록에서 상품 아이디와 일치하는 상품을 가져온다
		}
		//저장한 데이터를 반환한다
		return productById;
	}
	//2022-03-08 추가 끝--------------------------------------------------------
	
	//2022-03-10 추가----------------------------------------------------------
	//저장소에 신규 제품을 추가하는 메소드
	public void addProduct(Product product) {
		listOfProducts.add(product);
	}
	//2022-03-10 추가 끝--------------------------------------------------------
}
