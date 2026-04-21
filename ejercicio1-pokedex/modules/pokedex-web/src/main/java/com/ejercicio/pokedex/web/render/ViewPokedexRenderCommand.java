package com.ejercicio.pokedex.web.render;

import com.ejercicio.pokedex.web.service.PokeApiService;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCRenderCommand;

import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import java.util.ArrayList;
import java.util.List;

import com.ejercicio.pokedex.web.dto.PokemonListItem;


import org.osgi.service.component.annotations.Component;

import org.osgi.service.component.annotations.Reference;



import com.ejercicio.pokedex.web.constants.PokedexPortletKeys;

@Component(
        property = {
                "javax.portlet.name=" + PokedexPortletKeys.POKEDEX,
                "mvc.command.name=/"
        },
        service = MVCRenderCommand.class
)
public class ViewPokedexRenderCommand implements MVCRenderCommand {

    @Reference
    private PokeApiService service;


    @Override
    public String render(RenderRequest renderRequest, RenderResponse renderResponse) {

        int page = 1;
        int limit = 20;

        String pageParam = renderRequest.getParameter("page");

        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }

        int offset = (page - 1) * limit;

        try {

            JSONObject json = service.getPokemonPage(limit, offset);

            JSONArray results = json.getJSONArray("results");

            List<PokemonListItem> items = new ArrayList<>();

            for (int i = 0; i < results.length(); i++) {

                JSONObject pokemon = results.getJSONObject(i);

                String name = pokemon.getString("name");
                String url = pokemon.getString("url");

                // Extraer ID
                String[] parts = url.split("/");
                String idStr = parts[parts.length - 1].isEmpty()
                        ? parts[parts.length - 2]
                        : parts[parts.length - 1];

                int id = Integer.parseInt(idStr);

                int visibleIndex = ((page - 1) * limit) + i + 1;

                String imageUrl =
                        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
                                + id + ".png";

                items.add(new PokemonListItem(id, name, imageUrl, visibleIndex));
            }

            renderRequest.setAttribute("pokemonItems", items);
            renderRequest.setAttribute("currentPage", page);
            renderRequest.setAttribute("totalCount", json.getInt("count"));

        } catch (Exception e) {
            e.printStackTrace();
            renderRequest.setAttribute("error", true);
        }


        return "/view.jsp";
    }
}



