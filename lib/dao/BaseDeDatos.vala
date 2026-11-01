using Sqlite;
using GLib;


namespace Dao {

    /**
    * Clase que implementa al Dao
    */
    public class BaseDeDatos : Object, CancionDao {
        
        private static BaseDeDatos? baseCancion = null;
        private const string SCHEMA_SQL = 
            "";        
        private Database db;
        private const string NOMBRE_BASE = "baseCancion.db";
        private string archivo_nombre;


        private BaseDeDatos(){
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
                carga_schema ();
                return;
            }

            if (Database.open(archivo_nombre, out db) != Sqlite.OK){
                    stderr.printf ("No se puede crear la base de datos:" + db.errmsg ());
            }
            carga_schema (); 
        }

           
        /* La ruta y nombre de la base de datos */
        private string construye_nombre (){
            var nombre = string.join(GLib.Path.DIR_SEPARATOR_S,
                                         GLib.Environment.get_user_data_dir(),
                                         "baseMusical"); // revisar esta línea
            return string.join(GLib.Path.DIR_SEPARATOR_S, nombre, NOMBRE_BASE);
        }

        private void carga_schema (){
            try{
                string contenido_sql;
                FileUtils.get_contents(SCHEMA_SQL, out contenido_sql);

                if (db.exec(contenido_sql) != Sqlite.OK){
                    var err = db.errmsg();
                    critical("Error al aplicar la plantilla: %s", err);
                    return;
                }

            } catch (Error e ){
                critical("Error al cargar: %s", e.message);
            }
        }

        public static BaseDeDatos getBase(){
            if (baseCancion == null){
                baseCancion = new BaseDeDatos();
            }
            return baseCancion;
        }

        public void añade_cancion (Cancion cancion){
            var id = cancion.id;
            var interprete = cancion.interprete;
            var titulo = cancion.titulo;
            var album = cancion.album;
            var fecha_grabacion = cancion.fecha_grabacion;
            var tipo_contenido = cancion.tipo_contenido;
            var numero_pista = cancion.numero_pista;

            if (cancion_existe(id)){
                return;
            }



        }

        private bool cancion_existe (string id){

        }

        
        public void actualiza_cancion (Cancion cancion, Editables campo, string cambio){

        }

        public ArrayList<Cancion> obten_canciones (){

        }
        public ArrayList<Cancion> busca (string termino_busqueda) {

        }
    }
}