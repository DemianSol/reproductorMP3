using GLib;
using Gee;

namespace Mineria{

    internal class Lector{

        private File directorio;

        internal Lector(string ruta){
            File dir = File.new_for_path (ruta);
            if (! verifica_ruta (dir)){
                stderr.printf("La ruta %s no es un directorio o no apunta a uno\n", ruta);
            }
            this.directorio = dir;
        }

        /**
        * Verifica que la ruta exista y que sea un directorio. 
        * @param objeto de tipo File construido a partir de una ruta
        * @return true si la ruta existe y es un directorio; false en otro caso
         */
        private bool verifica_ruta(File dir){
            return (dir.query_exists ()) && (dir.query_file_type (0) == FileType.DIRECTORY);  
        }

        /**
        * Reconoce y almacena todos los archivos MP3 con versión de metadatos id3v2.4.0
        * @return Una lista que contiene todos los archivos de MP3 con el formato buscado
        */
        
        public ArrayList<File> obtener_MP3 () throws Error{

            var lista_mp3 = new ArrayList<File> ();
            var temp = aux_obtener_MP3 (this.directorio, lista_mp3);

            return temp;
        }
        
        public ArrayList<File> aux_obtener_MP3 (File dir, ArrayList<File> lista_mp3) throws Error{

         
            var cancelable = new Cancellable (); 
            FileEnumerator ennumerador = this.directorio.enumerate_children (
                FileAttribute.STANDARD_NAME,
                FileQueryInfoFlags.NOFOLLOW_SYMLINKS,
                cancelable
            );

            FileInfo ? info = null;
            while (!cancelable.is_cancelled () && ((info = ennumerador.next_file (cancelable)) != null) ){

                if (info.get_file_type () == FileType.DIRECTORY) {
                    File directory = dir.get_child (info.get_name ());
                    lista_mp3 = aux_obtener_MP3 (directory, lista_mp3);
                    continue;
                }

                if (info.get_content_type () == "audio/mpeg"){
                    File arc = dir.get_child (info.get_name() );
                    if (verifica_formato (arc)){
                        lista_mp3.add (arc);
                        continue;
                    }
                    continue;   
                }
            }
            if (cancelable.is_cancelled ()) {
                throw new IOError.CANCELLED ("Operation was cancelled");
            }

            return lista_mp3;
        }
    

    /*
    * Verifica que el archivo sea de tipo MP3 con versión de metadatos id3v2.4.0
    * @param objeto de tipo File 
    * return booleano que indica si el objeto es de tipo MP3 y con versión de metadatos id3v2.4.0
    */
        private bool verifica_formato(File mp3) throws Error{
            try{
                var file_stream = mp3.read ();
                //var data_stream = new DataInputStream (file_stream);
                //data_stream.set_byte_order (DataStreamByteOrder.BIG_ENDIAN);

                uint8 header[10];
                size_t bytes_leidos;

                file_stream.read_all(header, out bytes_leidos);

                if (bytes_leidos >= 5){
                    uint8[] etiqueta = header[0:5];
                    uint8[] formato_valido = {0x49, 0x44, 0x33, 0x04, 0x00};

                    return (Memory.cmp(etiqueta, formato_valido, 5)) == 0;
                } else{
                    return false;    
                }
            } catch(IOError error){
                stderr.printf("Error al leer el archivo: %s/n", error.message);
                return false;
            }
        }
    }


}