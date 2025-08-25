package utils; // Ou o pacote que preferir

import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Adaptador para o Gson serializar e desserializar objetos LocalDateTime.
 * Converte LocalDateTime para uma String no formato ISO_LOCAL_DATE_TIME e vice-versa.
 */
public class LocalDateTimeAdapter extends TypeAdapter<LocalDateTime> {

    // Define o formato padrão para a data e hora
    private static final DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;

    @Override
    public void write(JsonWriter out, LocalDateTime value) throws IOException {
        if (value == null) {
            out.nullValue();
        } else {
            // Converte o objeto LocalDateTime para uma String formatada
            out.value(value.format(formatter));
        }
    }

    @Override
    public LocalDateTime read(JsonReader in) throws IOException {
        if (in.peek() == com.google.gson.stream.JsonToken.NULL) {
            in.nextNull();
            return null;
        }
        // Converte a String do JSON de volta para um objeto LocalDateTime
        return LocalDateTime.parse(in.nextString(), formatter);
    }
}
