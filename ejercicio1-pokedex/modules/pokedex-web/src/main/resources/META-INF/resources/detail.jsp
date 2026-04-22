<%@ include file="/init.jsp" %>
<%@ page import="com.ejercicio.pokedex.web.dto.PokemonDetail" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
Boolean error = (Boolean) request.getAttribute("error");
PokemonDetail detail =
        (PokemonDetail) request.getAttribute("pokemonDetail");
%>

<div class="pokedex-container">

    <% if (Boolean.TRUE.equals(error) || detail == null) { %>

        <div class="pokedex-error">
            Error al cargar el Pokémon.
        </div>

    <% } else { %>

        <portlet:renderURL var="backURL" />

        <div class="pokemon-detail-card">

            <div class="detail-header">
                <span class="detail-number">#<%= detail.getId() %></span>
                <h2 class="detail-name">
                    <%= detail.getName().substring(0,1).toUpperCase() + detail.getName().substring(1) %>
                </h2>
            </div>

            <div class="detail-body">

                <img src="<%= detail.getImageUrl() %>"
                     alt="<%= detail.getName() %>"
                     class="detail-image" />

                <div class="detail-info">

                    <div class="detail-row">
                        <span class="label">Altura</span>
                        <span><%= detail.getHeight() %></span>
                    </div>

                    <div class="detail-row">
                        <span class="label">Peso</span>
                        <span><%= detail.getWeight() %></span>
                    </div>

                    <div class="detail-row">
                        <span class="label">Tipos</span>
                        <div class="type-container">
                            <% for (String type : detail.getTypes()) { %>
                                <span class="pokemon-type">
                                    <%= type.substring(0,1).toUpperCase() + type.substring(1) %>
                                </span>
                            <% } %>
                        </div>
                    </div>

                </div>

            </div>

            <div class="detail-footer">
                <a href="<%= backURL %>" class="back-button">
                    ← Volver a la Pokédex
                </a>
            </div>

        </div>

    <% } %>

</div>
