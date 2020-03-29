import java.util.Collection;
import java.util.Scanner;

import ejemplo.cajero.modelo.Banco;
import ejemplo.cajero.modelo.Cuenta;

public aspect SaldoReducido {
	
	pointcut reemplazarRetiroSAldoReducido(): call(* ejemplo.cajero.control.Comando.ejecutar(..));
	
	void around() throws Exception : reemplazarRetiroSAldoReducido() { 
		
		String nombreObjeto = thisJoinPoint.getTarget().toString();
		int esRetiro = nombreObjeto.indexOf("Retirar");
		int esTransaccion = nombreObjeto.indexOf("Transferir");
		
		if(esRetiro != -1) {
			System.out.println("Retiro de Dinero");
			System.out.println();
			
			// la clase Console no funciona bien en Eclipse
			Scanner console = new Scanner(System.in);			
			
			// Ingresa los datos
			System.out.println("Ingrese el número de cuenta");
			String numeroDeCuenta = console.nextLine();
			
			Object [] args = thisJoinPoint.getArgs();
			Banco contexto = new Banco();
			for (Object arg : args) {
				contexto = (Banco)arg;
			}
			
			Cuenta cuenta = contexto.buscarCuenta(numeroDeCuenta);
			if (cuenta == null) {
				throw new Exception("No existe cuenta con el número " + numeroDeCuenta);
			}
			
			System.out.println("Ingrese el valor a retirar");
			String valor = console.nextLine();
			
			long saldoReducido = cuenta.getSaldo() - Long.parseLong(valor);
			if(saldoReducido <= 200000) {
				throw new Exception("El cajero cuenta con la opcion de saldo reducido. No se completa el retiro.");
			}else {
				try {
					long valorNumerico = Long.parseLong(valor);
					cuenta.retirar(valorNumerico);
				
				} catch (NumberFormatException e) {
					throw new Exception("Valor a retirar no válido : " + valor);
				}
			}
			
		}else {
			if(esTransaccion != -1) {
				System.out.println("Transferencia de Dinero");
				System.out.println();
				
				// la clase Console no funciona bien en Eclipse
				Scanner console = new Scanner(System.in);			
				
				// Ingresa los datos
				System.out.println("Ingrese el número de cuenta origen");
				String numeroCuentaOrigen = console.nextLine();
				
				Object [] args = thisJoinPoint.getArgs();
				Banco contexto = new Banco();
				for (Object arg : args) {
					contexto = (Banco)arg;
				}
				
				Cuenta cuentaOrigen = contexto.buscarCuenta(numeroCuentaOrigen);
				if (cuentaOrigen == null) {
					throw new Exception("No existe cuenta con el número " + numeroCuentaOrigen);
				}

				System.out.println("Ingrese el número de cuenta destino");
				String numeroCuentaDestino = console.nextLine();
				
				Cuenta cuentaDestino = contexto.buscarCuenta(numeroCuentaDestino);
				if (cuentaDestino == null) {
					throw new Exception("No existe cuenta con el número " + numeroCuentaDestino);
				}
				
				System.out.println("Ingrese el valor a transferir");
				String valor = console.nextLine();
				
				long saldoReducido = cuentaOrigen.getSaldo() - Long.parseLong(valor);
				
				if(saldoReducido <= 200000) {
					throw new Exception("¡¡¡¡El cajero cuenta con la opcion de saldo reducido!!!!. No se completa la transferencia.!");
				}else {
					try {
						
						// se retira primero y luego se consigna
						// si no se puede retirar, no se hace la consignación
						
						long valorNumerico = Long.parseLong(valor);
						cuentaOrigen.retirar(valorNumerico);
						cuentaDestino.consignar(valorNumerico);
					
					} catch (NumberFormatException e) {
						throw new Exception("Valor a transferir no válido : " + valor);
					}
				}
				
			}else {				
				proceed();
			}
		}
	}
}