package com.ejercicio.pokedex.web.dto;

import java.util.List;

public class PokemonDetail {

    private final int id;
    private final String name;
    private final int height;
    private final int weight;
    private final String imageUrl;
    private final List<String> types;

    public PokemonDetail(
            int id,
            String name,
            int height,
            int weight,
            String imageUrl,
            List<String> types) {

        this.id = id;
        this.name = name;
        this.height = height;
        this.weight = weight;
        this.imageUrl = imageUrl;
        this.types = types;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public int getHeight() { return height; }
    public int getWeight() { return weight; }
    public String getImageUrl() { return imageUrl; }
    public List<String> getTypes() { return types; }
}

