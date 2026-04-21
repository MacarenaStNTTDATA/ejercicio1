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
%>

<h2>Pokédex</h2>

<% if (Boolean.TRUE.equals(error)) { %>

    <div style="color:red;">Error al cargar los datos.</div>

<% } else if (items == null || items.isEmpty()) { %>

    <div>No hay Pokémon disponibles.</div>

<% } else { %>

    <ul style="list-style:none; padding:0;">

    <% for (PokemonListItem item : items) { %>

        <li style="margin-bottom:15px; display:flex; align-items:center; gap:10px;">

            <img src="<%= item.getImageUrl() %>" width="72" height="72" />

            <portlet:renderURL var="detailURL">
                <portlet:param name="mvcRenderCommandName" value="/pokemon/detail" />
                <portlet:param name="name" value="<%= item.getName() %>" />
            </portlet:renderURL>

            <a href="<%= detailURL %>">
                #<%= item.getVisibleIndex() %> - <%= item.getName() %>
            </a>

        </li>

    <% } %>

    </ul>

    <div style="margin-top:20px;">

        <% if (currentPage > 1) { %>
            <portlet:renderURL var="prevURL">
                <portlet:param name="page" value="<%= String.valueOf(currentPage - 1) %>" />
            </portlet:renderURL>
            <a href="<%= prevURL %>">Anterior</a>
        <% } %>

        <%
        int startPage = Math.max(1, currentPage - 1);
        int endPage = Math.min(totalPages, currentPage + 1);

        for (int i = startPage; i <= endPage; i++) {
        %>

            <portlet:renderURL var="pageURL">
                <portlet:param name="page" value="<%= String.valueOf(i) %>" />
            </portlet:renderURL>

            <% if (i == currentPage) { %>
                <strong><%= i %></strong>
            <% } else { %>
                <a href="<%= pageURL %>"><%= i %></a>
            <% } %>

        <% } %>

        <% if (currentPage < totalPages) { %>
            <portlet:renderURL var="nextURL">
                <portlet:param name="page" value="<%= String.valueOf(currentPage + 1) %>" />
            </portlet:renderURL>
            <a href="<%= nextURL %>">Siguiente</a>
        <% } %>

    </div>

<% } %>
