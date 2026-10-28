using Gee;

namespace Database.Dao{

    internal interface Dao : Object {

        public abstract void añade_cancion (Cancion cancion);
        public abstract void actualiza_cancion (Cancion cancion, Editables campo, string cambio); 
        public abstract ArrayList<Cancion> obten_canciones();
        public abstract ArrayList<Cancion> busca (string termino_busqueda);
    }
}