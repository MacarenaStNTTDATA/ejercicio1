package com.ejercicio.pokedex.web.portlet;

import com.ejercicio.pokedex.web.constants.PokedexPortletKeys;

import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;

import javax.portlet.Portlet;

import org.osgi.service.component.annotations.Component;

/**
 * @author mmoralto
 */
@Component(
	property = {
		"com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
            "com.liferay.portlet.css-class-wrapper=pokedex-web",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=Pokedex",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + PokedexPortletKeys.POKEDEX,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class PokedexPortlet extends MVCPortlet {
}