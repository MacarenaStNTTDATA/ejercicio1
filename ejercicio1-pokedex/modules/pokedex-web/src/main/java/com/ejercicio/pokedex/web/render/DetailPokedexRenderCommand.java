package com.ejercicio.pokedex.web.render;

import com.ejercicio.pokedex.web.service.PokeApiService;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCRenderCommand;

import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.ejercicio.pokedex.web.dto.PokemonDetail;

import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONObject;

import java.util.ArrayList;
import java.util.List;


import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import com.ejercicio.pokedex.web.constants.PokedexPortletKeys;

@Component(
        property = {
                "javax.portlet.name=" + PokedexPortletKeys.POKEDEX,
                "mvc.command.name=/pokemon/detail"
        },
        service = MVCRenderCommand.class
)
public class DetailPokedexRenderCommand implements MVCRenderCommand {

    @Reference
    private PokeApiService service;

    @Override
    public String render(RenderRequest renderRequest, RenderResponse renderResponse) {

        String name = renderRequest.getParameter("name");
        System.out.println("NAME = " + name);

        if (name == null || name.isEmpty()) {
            renderRequest.setAttribute("error", true);
            return "/detail.jsp";
        }

        try {

            JSONObject json = service.getPokemonDetail(name);

            int id = json.getInt("id");
            int height = json.getInt("height");
            int weight = json.getInt("weight");

            String imageUrl =
                    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
                            + id + ".png";

            // Extraer tipos
            JSONArray typesArray = json.getJSONArray("types");
            List<String> types = new ArrayList<>();

            for (int i = 0; i < typesArray.length(); i++) {
                JSONObject typeObj = typesArray.getJSONObject(i);
                String typeName = typeObj
                        .getJSONObject("type")
                        .getString("name");

                types.add(typeName);
            }

            PokemonDetail detail = new PokemonDetail(
                    id,
                    name,
                    height,
                    weight,
                    imageUrl,
                    types
            );

            renderRequest.setAttribute("pokemonDetail", detail);

        } catch (Exception e) {
            renderRequest.setAttribute("error", true);
        }

        return "/detail.jsp";
    }
}

