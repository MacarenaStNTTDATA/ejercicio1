package com.ejercicio.pokedex.web.service;

import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.json.JSONFactoryUtil;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import org.osgi.service.component.annotations.Component;

@Component(service = PokeApiService.class)
public class PokeApiService {

    private static final String BASE_URL = "https://pokeapi.co/api/v2/pokemon";

    public JSONObject getPokemonPage(int limit, int offset) throws Exception {
        //Demo Loading
        Thread.sleep(1500);

        String urlString = BASE_URL + "?limit=" + limit + "&offset=" + offset;
        // Demo Error: BASE_URL = "https://pokeapi.co/api/v2/pokemonXXXX";

        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        connection.setRequestMethod("GET");

        int responseCode = connection.getResponseCode();

        if (responseCode != 200) {
            throw new RuntimeException("Error en la llamada a PokéAPI: " + responseCode);
        }

        BufferedReader in = new BufferedReader(
                new InputStreamReader(connection.getInputStream())
        );

        String inputLine;
        StringBuilder response = new StringBuilder();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }

        in.close();
        connection.disconnect();

        return JSONFactoryUtil.createJSONObject(response.toString());
    }

    public JSONObject getPokemonDetail(String name) throws Exception {

        String urlString = BASE_URL + "/" + name;

        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();

        connection.setRequestMethod("GET");

        int responseCode = connection.getResponseCode();

        if (responseCode != 200) {
            throw new RuntimeException("Error en detalle PokéAPI: " + responseCode);
        }

        BufferedReader in = new BufferedReader(
                new InputStreamReader(connection.getInputStream())
        );

        String inputLine;
        StringBuilder response = new StringBuilder();

        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }

        in.close();
        connection.disconnect();

        return JSONFactoryUtil.createJSONObject(response.toString());
    }
}

