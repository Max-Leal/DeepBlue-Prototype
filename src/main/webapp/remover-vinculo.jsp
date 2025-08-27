<%@page import="java.lang.ProcessBuilder.Redirect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="models.Agencia, java.util.*, models.Local, models.AgenciaLocal, daos.LocalDao, controllers.LocalController, controllers.AgenciaLocalController"%>
<%
Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
String localIdParam = request.getParameter("id");
AgenciaLocalController alc = new AgenciaLocalController();

alc.remover(agenciaLogada.getId(), Long.parseLong(localIdParam));
response.sendRedirect("painel-agencia.jsp");
%>