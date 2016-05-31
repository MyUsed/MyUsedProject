package admin;

public class pagingAction {
	
	private int currentPage;   // ����������
	private int totalCount;	 // ��ü �Խù� ��
	private int totalPage;	 // ��ü ������ ��
	private int blockCount;	 // �� ��������  �Խù��� ��
	private int blockPage;	 // �� ȭ�鿡 ������ ������ ��
	private int startCount;	 // �� ���������� ������ �Խñ��� ���� ��ȣ
	private int endCount;	 // �� ���������� ������ �Խñ��� �� ��ȣ
	private int startPage;	 // ���� ������
	private int endPage;	 // ������ ������
	
	private StringBuffer pagingHtml;
	
	// ����¡ ������
	public pagingAction(int currentPage, int totalCount, int blockCount,
			int blockPage) {
		
		this.blockCount = blockCount;
		this.blockPage = blockPage;
		this.currentPage = currentPage;
		this.totalCount = totalCount;
		
		// ��ü ������ ��
		totalPage = (int) Math.ceil((double) totalCount / blockCount);
		if (totalPage == 0) {
			totalPage = 1;
		}
		
		// ���� �������� ��ü ������ ������ ũ�� ��ü ������ ���� ����
		if (currentPage > totalPage) {
			currentPage = totalPage;
		}
		
		// ���� �������� ó���� ������ ���� ��ȣ ��������.
		startCount = (currentPage - 1) * blockCount;
		endCount = startCount + blockCount - 1;
		
		// ���� �������� ������ ������ �� ���ϱ�.
		startPage = (int) ((currentPage - 1) / blockPage) * blockPage + 1;
		endPage = startPage + blockPage - 1;
		
		// ������ �������� ��ü ������ ������ ũ�� ��ü ������ ���� ����
		if (endPage > totalPage) {
			endPage = totalPage;
		}
		
		// ���� block ������
		pagingHtml = new StringBuffer();
		if (currentPage > blockPage) {
			pagingHtml.append("<a href=applyBanner.nhn?currentPage="
					+ (startPage - 1) + ">");
			pagingHtml.append("����");
			pagingHtml.append("</a>");
		}
		
		pagingHtml.append("&nbsp;|&nbsp;");
		
		//������ ��ȣ.���� �������� ���������� �����ϰ� ��ũ�� ����.
		for (int i = startPage; i <= endPage; i++) {
			if (i > totalPage) {
				break;
			}
			if (i == currentPage) {
				pagingHtml.append("&nbsp;<b> <font color='red'>");
				pagingHtml.append(i);
				pagingHtml.append("</font></b>");
			} else {
				pagingHtml
				.append("&nbsp;<a href='applyBanner.nhn?currentPage=");
				pagingHtml.append(i);
				pagingHtml.append("'>");
				pagingHtml.append(i);
				pagingHtml.append("</a>");
			}
			
			pagingHtml.append("&nbsp;");
		}
		
		pagingHtml.append("&nbsp;&nbsp;|&nbsp;&nbsp;");
		
		// ���� block ������
		if (totalPage - startPage >= blockPage) {
			pagingHtml.append("<a href=applyBanner.nhn?currentPage="
					+ (endPage + 1) + ">");
			pagingHtml.append("����");
			pagingHtml.append("</a>");
		}
	}
	
	
	public void setCurrentPage(int currentPage) {this.currentPage = currentPage;}
	public void setTotalCount(int totalCount) {this.totalCount = totalCount;}
	public void setTotalPage(int totalPage) {this.totalPage = totalPage;}
	public void setBlockCount(int blockCount) {this.blockCount = blockCount;}
	public void setBlockPage(int blockPage) {this.blockPage = blockPage;}
	public void setStartCount(int startCount) {this.startCount = startCount;}
	public void setEndCount(int endCount) {this.endCount = endCount;}
	public void setStartPage(int startPage) {this.startPage = startPage;}
	public void setEndPage(int endPage) {this.endPage = endPage;}
	public void setPagingHtml(StringBuffer pagingHtml) {this.pagingHtml = pagingHtml;}
	
	
	public int getCurrentPage() {return currentPage;}
	public int getTotalCount() {return totalCount;}
	public int getTotalPage() {return totalPage;}
	public int getBlockCount() {return blockCount;}
	public int getBlockPage() {return blockPage;}
	public int getStartCount() {return startCount;}
	public int getEndCount() {return endCount;}
	public int getStartPage() {return startPage;}
	public int getEndPage() {return endPage;}
	public StringBuffer getPagingHtml() {return pagingHtml;}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
