package board.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class BoardWithCommentCnt extends Board 
								 implements Serializable{
	private int commentCnt;

	public BoardWithCommentCnt() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BoardWithCommentCnt(int boardNo, String boardTitle, String boardWriter, String boardContent,
			String originalFileName, String renamedFileName, Date boardDate, int readCount, int commentCnt) {
		super(boardNo, boardTitle, boardWriter, boardContent, originalFileName, renamedFileName, boardDate, readCount);
		this.commentCnt = commentCnt;
	}
	public int getCommentCnt() {
		return commentCnt;
	}
	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}
	@Override
	public String toString() {
		return "BoardWithCommentCnt [commentCnt=" + commentCnt + ", getBoardNo()=" + getBoardNo() + ", getBoardTitle()="
				+ getBoardTitle() + ", getBoardWriter()=" + getBoardWriter() + ", getBoardContent()="
				+ getBoardContent() + ", getOriginalFileName()=" + getOriginalFileName() + ", getRenamedFileName()="
				+ getRenamedFileName() + ", getBoardDate()=" + getBoardDate() + ", getReadCount()=" + getReadCount()
				+ ", toString()=" + super.toString() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ "]";
	}
}
