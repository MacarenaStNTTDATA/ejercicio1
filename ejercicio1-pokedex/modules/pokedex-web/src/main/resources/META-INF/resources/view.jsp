<%@ include file="/init.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ejercicio.pokedex.web.dto.PokemonListItem" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
Boolean error = (Boolean) request.getAttribute("error");
List<PokemonListItem> items =
        (List<PokemonListItem>) request.getAttribute("pokemonItems");
Integer currentPage = (Integer) request.getAttribute("currentPage");
Integer totalCount = (Integer) request.getAttribute("totalCount");

int limit = 20;
int totalPages = 0;

if (totalCount != null) {
    totalPages = (int) Math.ceil((double) totalCount / limit);
}

if (currentPage == null) {
    currentPage = 1;
}

int startPage = Math.max(1, currentPage - 1);
int endPage = Math.min(totalPages, currentPage + 1);
%>

 <div id="loadingOverlay" class="loading-overlay">
            <div class="spinner"></div>
            <p>Cargando Pokémon...</p>
        </div>

<div class="pokedex-container">

    <% if (Boolean.TRUE.equals(error)) { %>

        <div class="pokedex-error">
            Error al cargar los Pokémon.

            <portlet:renderURL var="retryURL" />
            <a href="<%= retryURL %>" class="retry-button">
                Reintentar
            </a>
        </div>

    <% } else if (items == null || items.isEmpty()) { %>

        <div class="pokedex-empty">
            No hay Pokémon disponibles.
        </div>

    <% } else { %>

        <div class="pokedex-grid">

            <% for (PokemonListItem item : items) { %>

                <portlet:renderURL var="detailURL">
                    <portlet:param name="mvcRenderCommandName" value="/pokemon/detail" />
                    <portlet:param name="name" value="<%= item.getName() %>" />
                </portlet:renderURL>

                <a href="<%= detailURL %>" class="pokemon-card">

                    <div class="pokemon-number">
                        #<%= item.getVisibleIndex() %>
                    </div>

                    <img src="<%= item.getImageUrl() %>" alt="<%= item.getName() %>" />

                    <div class="pokemon-name">
                        <%= item.getName().substring(0,1).toUpperCase() + item.getName().substring(1) %>
                    </div>

                </a>

            <% } %>

        </div>

        <% if (totalPages > 1) { %>

            <div class="pagination">

                <% if (currentPage > 1) { %>
                    <portlet:renderURL var="prevURL">
                        <portlet:param name="page" value="<%= String.valueOf(currentPage - 1) %>" />
                    </portlet:renderURL>
                    <a href="<%= prevURL %>" class="page-arrow">←</a>
                <% } %>

                <% for (int i = startPage; i <= endPage; i++) { %>

                    <portlet:renderURL var="pageURL">
                        <portlet:param name="page" value="<%= String.valueOf(i) %>" />
                    </portlet:renderURL>

                    <% if (i == currentPage) { %>
                        <span class="active"><%= i %></span>
                    <% } else { %>
                        <a href="<%= pageURL %>"><%= i %></a>
                    <% } %>

                <% } %>

                <% if (currentPage < totalPages) { %>
                    <portlet:renderURL var="nextURL">
                        <portlet:param name="page" value="<%= String.valueOf(currentPage + 1) %>" />
                    </portlet:renderURL>
                    <a href="<%= nextURL %>" class="page-arrow">→</a>
                <% } %>

            </div>

        <% } %>

    <% } %>

</div>

<script>
    setTimeout(function () {
        var loader = document.getElementById("loadingOverlay");
        if (loader) {
            loader.style.display = "none";
        }
    }, 1200);
</script>


