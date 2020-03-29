import java.util.Collection;

import ejemplo.cajero.modelo.Banco;
import ejemplo.cajero.modelo.Cuenta;
public aspect ListadoOperaciones {
	
	pointcut metodosDeTransacciones(): call(* ejemplo.cajero.control.Comando.ejecutar(..));
	
	
	before(): metodosDeTransacciones(){
		System.out.println("*****Ejecutando log de Auditoria Cuentas Antes de  las transacciones*****");
		System.out.println("****Estado actual de las cuentas*****");
		System.out.println();
		Object [] args = thisJoinPoint.getArgs();
		for (Object arg : args) {
			Banco banco = new Banco();
			banco = (Banco)arg;
			Collection<Cuenta> listCuentas = banco.getCuentas();
			for(Cuenta cuenta : listCuentas) {
				System.out.println(cuenta.getNumero() + " : $ " + cuenta.getSaldo());
			}
		}
		System.out.println("La transaccion ejecutada es: ");
	}
	
	after() returning(Object resultado): metodosDeTransacciones(){ 
		System.out.println("*****Ejecutando log de Auditoria Cuentas Despues de  las transacciones*****");
		System.out.println("****Estado actual de las cuentas*****");
		Object [] args = thisJoinPoint.getArgs();
		for (Object arg : args) {
			Banco banco = new Banco();
			banco = (Banco)arg;
			Collection<Cuenta> listCuentas = banco.getCuentas();
			for(Cuenta cuenta : listCuentas) {
				System.out.println(cuenta.getNumero() + " : $ " + cuenta.getSaldo());
			}
		}
		System.out.println("****Fin del Log*****");
		
	}
	after() throwing(Throwable e) : metodosDeTransacciones() {
		System.out.println("*****Ejecutando log de Auditoria Cuentas Despues de  las transacciones*****");
		System.out.println("*****No se realizo la transaccion *****");
		System.out.println("Retornando con Excepción \t");
	    System.out.println("\t excepción : " + e.getMessage());
	    System.out.println("****Fin del Log*****");
	}
	
}