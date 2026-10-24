using TagLib;
using GLib;
using Gee;


namespace Mineria{
    
    public class Minero {

        string ruta;

        public Minero(string ruta){
            this.ruta = ruta;
        }

        /**
        * Ejecuta el minero recorriendo la ruta especificada. Identifica cada 
        */
        public ArrayList<Cancion> ejecuta(){
            Lector lector = new Lector(ruta);
            ArrayList<GLib.File> archivos = lector.obtener_MP3 ();
            var canciones = obten_tag (archivos);
            return canciones;
        } 

        /*
        * Para cada archivo mp3 intenta generar una instancia de Cancion con información sobre su ruta, ruta de su álbum, intérprete, título, album, año, género 
        * y número de pista. Si no se puede abrir y leer sus metadatos, el archivo se omite.
        * @param lista de archivos mp3
        * @return lista de Canciones
        */ 
        private ArrayList<Cancion> obten_tag (ArrayList<GLib.File> archivos){
            
            var canciones = new ArrayList<Cancion> ();
            foreach (GLib.File a in archivos){
                Cancion? cancion = genera_cancion (a);
                if (cancion != null){
                    canciones.add (cancion);
                }
            }
            return canciones;
        }

        /*
        * Genera una instancia de Cancion a partir de un archivo mp3 asignándole los metadatos contenidas en dicho archivo. 
        * @param el archivo mp3
        * @return si el archivo mp3 se puede abrir y leer devuelve la instancia de Cancion con los metadatos; null en otro caso.
        */
        private Cancion? genera_cancion (GLib.File archivo){

            var file = new TagLib.File (GLib.get_path (archivo));

            if (! file.is_valid ()){
                return null;
            }
            
            var cancion = new Cancion ();

            var tag = file.tag;

            cancion.ruta_cancion = GLib.get_path (archivo);
            cancion.ruta_album = archivo.get_parent (); // verificar con el correo de canek

            if (tag.artist == ""){
                cancion.interprete = "Unknown";
            }
            if (tag.artist != ""){
                cancion.interprete = tag.artist;
            }
            if (tag.title == ""){
                cancion.titulo = "Unknown";
            }
            if (tag.title != ""){
                cancion.titulo = tag.title;
            }
            if (tag.album == ""){
                cancion.album = "Unknown";
            }
            if (tag.album != ""){
                cancion.album = tag.album;
            }
            if (tag.year == uint.MIN){
                cancion.fecha_grabacion = uint.MIN;
            }
            if (tag.year != uint.MIN){
                cancion.fecha_grabacion = tag.year;
            }
            if (tag.genre == ""){
                cancion.tipo_contenido = "Unknown";
            }
            if (tag.genre != ""){
                cancion.tipo_contenido = tag.genre;
            }
            if (tag.track == uint.MIN){
                cancion.numero_pista = uint.MIN;
            }
            if (tag.track != uint.MIN){
                cancion.numero_pista = tag.track;
            }
            
            return cancion;

        }

    }
}
