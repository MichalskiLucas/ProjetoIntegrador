package br.integration.cookmasterapi.enums;

public enum EnumVoto {
	UMA("1 Estrela"),
	DUAS("2 Estrela"),
	TRES("3 Estrela"),
	QUATRO("4 Estrela"),
	CINCO("5 Estrela"),;
	
	public final String value;

	private EnumVoto(String value) {
		this.value = value;
	}

	public String getValue() {
		return value;
	}
}
