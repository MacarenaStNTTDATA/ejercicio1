package com.ejercicio.pokedex.web.dto;

public class PokemonListItem {

    private int id;
    private String name;
    private String imageUrl;
    private int visibleIndex;

    public PokemonListItem(int id, String name, String imageUrl, int visibleIndex) {
        this.id = id;
        this.name = name;
        this.imageUrl = imageUrl;
        this.visibleIndex = visibleIndex;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public String getImageUrl() { return imageUrl; }
    public int getVisibleIndex() { return visibleIndex; }
}
