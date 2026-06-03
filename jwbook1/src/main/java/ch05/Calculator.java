package ch05;

public class Calculator {
	private int n1;
	private int n2;
	private String op;

	public Calculator() {
	}

	public Calculator(int n1, int n2, String op) {
		this.n1 = n1;
		this.n2 = n2;
		this.op = op;
	}

	public void setN1(int n1) {
		this.n1 = n1;
	}

	public void setN2(int n2) {
		this.n2 = n2;
	}

	public void setOp(String op) {
		this.op = op;
	}

	public long calc() {
		if (op == null) {
			throw new IllegalStateException("연산자(op)가 설정되지 않았습니다.");
		}

		long result;
		switch(op) {
			case "+": result = (long) n1 + n2; break;
			case "-": result = (long) n1 - n2; break;
			case "/":
				if (n2 == 0) {
					throw new ArithmeticException("0으로 나눌 수 없습니다.");
				}
				result = n1 / n2;
				break;
			case "*": result = (long) n1 * n2; break;
			default:
				throw new IllegalArgumentException("지원하지 않는 연산자입니다: " + op);
		}
		return result;
	}

}

