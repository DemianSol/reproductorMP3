

namespace Database.Dao{

    internal interface Dao : Object {

        public abstract void añade_cancion (Cancion cancion);
        public abstract void actualiza_cancion (Cancion cancion, Editables campo, string cambio); // parametros por definir
    }
}