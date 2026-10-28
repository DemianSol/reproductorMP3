using Sqlite;
using GLib;

// get_user_data_dir()

namespace Dao {

    /**
    * Clase que implementar al Dao
    */
    public class BaseDeDatos : Object, CancionDao {
        
        private const string SCHEMA_SQL = 
            "";        
        private Database db;
        private const string NOMBRE_BASE = "baseCancion.db";


        public BaseDeDatos(){

        }

        private void inicia_base (){

        }

        private string construye_nombre (){

        }

        public void añade_cancion (Cancion cancion){

        }

        public  void actualiza_cancion (Cancion cancion, Editables campo, string cambio){

        }

        public  ArrayList<Cancion> obten_canciones (){

        }
        public  ArrayList<Cancion> busca (string termino_busqueda) {

        }
    }
}