package member.model.exception;

public class MemberException extends Exception {
	public MemberException(){}
	
	public MemberException(String message){
		super(message);
	}
	
	public MemberException(String message, Throwable cause) {
		super(message, cause);
	}
	
	public MemberException(Throwable cause) {
		super(cause);
	}
}

