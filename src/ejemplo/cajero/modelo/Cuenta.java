package ejemplo.cajero.modelo;

public class Cuenta {

	private String numero;
	private String clave;
	private long saldo;
	
	// constructor que recibe la clave y el saldo de la cuenta
	public Cuenta(String numero, String clave, long saldo) {
		this.numero = numero;
		this.clave  = clave;
		this.saldo  = saldo;
	}
	
	// obtiene el número de la cuenta
	public String getNumero() {
		return numero;
	}
	
	// obtiene el valor del saldo
	public long getSaldo() {
		return saldo;
	}
	
	// cambia la clave de la cuenta
	public void cambiarClave(String claveAnterior, String claveNueva) throws Exception {
		
		// cambia la clave si la clave anterior es correcta
		if (this.clave.equals(claveAnterior)) {
			this.clave = claveNueva;
		}
	}
	
	// hace una consignación
	public void consignar(long valor) throws Exception {
		
		// solo se hace la consignación si el valor es mayor que cero
		if (valor < 0) {
			throw new Exception("No se puede consignar un valor negativo");
		}
		this.saldo += valor;
	}
	
	// hace un retiro
	public void retirar(long valor) throws Exception {
		
		// solo se hace el retiro si el valor es mayor que cero
		// y el valor es mayor que el saldo actual
		if (valor < 0) {
			throw new Exception("No se puede retirar un valor negativo");
		}
		if (valor > this.saldo) {
			throw new Exception("No se puede retirar un valor mayor al saldo");
		}
		this.saldo -= valor;
	}
		
}
