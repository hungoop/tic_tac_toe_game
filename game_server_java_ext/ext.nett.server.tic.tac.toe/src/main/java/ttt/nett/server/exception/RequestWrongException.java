package ttt.nett.server.exception;

import ttt.nett.server.command.LanguageKey;

public class RequestWrongException extends BaseTTTExcecption {
	private static final long serialVersionUID = -2006345871204481038L;
	
	public RequestWrongException() {
		super(LanguageKey.KEY_ERROR_REQUEST_WRONG);
	}

}
