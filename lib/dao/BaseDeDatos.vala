    using Sqlite;
using GLib;


namespace Dao {

    /**
    * Clase que implementa al Dao
    */
    public class BaseDeDatos : Object, CancionDao {
        
        private const string SCHEMA_SQL = 
            "";        
        private Database db;
        private const string NOMBRE_BASE = "baseCancion.db";
        private string nombre_base;


        public BaseDeDatos(){
            this.nombre_base = construye_nombre ();
            inicia_base();
        }

        private void inicia_base (){
            
        }   
        /* La ruta y nombre de la base de datos */
        private string construye_nombre (){
            var nombre = string.join(GLib.Path.DIR_SEPARATOR_S,
                                         GLib.Environment.get_user_data_dir(),
                                         "baseMusical"); // revisar esta línea
            return string.join(GLib.Path.DIR_SEPARATOR_S, nombre, NOMBRE_BASE);
        }

        public void añade_cancion (Cancion cancion){

        }

        public void actualiza_cancion (Cancion cancion, Editables campo, string cambio){

        }

        public ArrayList<Cancion> obten_canciones (){

        }
        public ArrayList<Cancion> busca (string termino_busqueda) {

        }
    }
}