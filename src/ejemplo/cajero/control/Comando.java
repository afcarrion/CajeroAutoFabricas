package ejemplo.cajero.control;

import ejemplo.cajero.modelo.Banco;

/**
 * Interfaz usada para permitir agregar y modificar los comandos
 * que se usan en el cajero
 */
public interface Comando {
	
	/**
	 * Retorna el nombre del comando, tal como va a aparece en pantalla
	 * @return Nombre del comando
	 */
	public String getNombre();
	
	/**
	 * Ejecuta el comando solicitado por el usuario
	 * @param contexto    Instancia de Banco que contiene las operaciones a utilizar 
	 * @throws Exception  Excepción que representa errores definidos por la lógica de negocio
	 */
	public void ejecutar(Banco contexto) throws Exception;

}
