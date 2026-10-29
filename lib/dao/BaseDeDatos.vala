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
        private string archivo_nombre;


        public BaseDeDatos(){
            this.archivo_nombre = construye_nombre ();
            inicia_base();
        }

        private void inicia_base (){
            var db_dirnombre = Path.get_dirname(archivo_nombre);

            var dir_flags = FileTest.EXISTS | FileTest.IS_DIR;
            if (! FileUtils.test(db_dirnombre, dir_flags))
                DirUtils.create_with_parents(db_dirnombre, 0755);
            
            var arc_flags = FileTest.EXISTS | FileTest.IS_REGULAR;
            if (! FileUtils.test(archivo_nombre, arc_flags)){
                if (Database.open(archivo_nombre, out db) != Sqlite.OK){
                    stderr.printf ("No se puede crear la base de datos:" + db.errmsg ());
                }
                db.exec(SCHEMA_SQL);
                return;
            }

            if (Database.open(archivo_nombre, out db) != Sqlite.OK){
                    stderr.printf ("No se puede crear la base de datos:" + db.errmsg ());
            }
            db.exec(SCHEMA_SQL); // DEVOLVER ERROR 
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