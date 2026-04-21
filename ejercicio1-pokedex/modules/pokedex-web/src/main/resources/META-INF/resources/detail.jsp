<%@ include file="/init.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.ejercicio.pokedex.web.dto.PokemonDetail" %>
<%@ page import="java.util.List" %>

<%
Boolean error = (Boolean) request.getAttribute("error");
PokemonDetail detail =
        (PokemonDetail) request.getAttribute("pokemonDetail");
%>

<h2>Detalle del Pokémon</h2>

<% if (Boolean.TRUE.equals(error)) { %>

    <div style="color:red;">
        Error al cargar el detalle del Pokémon.
    </div>

<% } else if (detail == null) { %>

    <div>No se encontró información.</div>

<% } else { %>

    <div style="display:flex; gap:30px; align-items:flex-start;">

        <img src="<%= detail.getImageUrl() %>" width="150" />

        <div>
            <p><strong>ID:</strong> <%= detail.getId() %></p>
            <p><strong>Nombre:</strong> <%= detail.getName() %></p>
            <p><strong>Altura:</strong> <%= detail.getHeight() %></p>
            <p><strong>Peso:</strong> <%= detail.getWeight() %></p>

            <p><strong>Tipos:</strong></p>
            <ul>
                <%
                for (String type : detail.getTypes()) {
                %>
                    <li><%= type %></li>
                <%
                }
                %>
            </ul>
        </div>

    </div>

<% } %>
