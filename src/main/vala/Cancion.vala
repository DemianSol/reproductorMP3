

public class Cancion : Object {

    public string ruta_cancion {get; set; }
    public string ruta_album {get; set;}
    public string interprete {get; set; }
    public string titulo {get; set; }
    public string album {get; set; }
    public uint fecha_grabacion {get; set; }   // puede que no deba ser unicamente un entero; revisar o preguntar
    public string tipo_contenido {get; set; }
    public uint numero_pista {get; set; } // no necesariamente es un int, ojo

}