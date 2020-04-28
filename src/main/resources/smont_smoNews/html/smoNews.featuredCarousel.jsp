<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:addResources type="css" resources="smoNews.css"/>

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="newsTitle"/>
<jcr:nodeProperty node="${currentNode}" name="desc" var="newsBody"/>
<jcr:nodeProperty node="${currentNode}" name="date" var="newsDate"/>
<jcr:nodeProperty node="${currentNode}" name="buttonText" var="newsButtonText"/>
<jcr:nodeProperty node="${currentNode}" name="featured" var="featured"/>

<c:set var="galleryImgs" value="${currentNode.properties['smoGalleryImg']}"/>

<c:set var="linkType" value="${currentNode.properties.linkType.string}" />
<c:set var="linkTarget" value="${currentNode.properties.linkTarget.string}" />

<c:choose>
    <c:when test="${linkType eq 'internalLink'}">
        <c:set var="internalLinkNode" value="${currentNode.properties.internalLink.node}"/>
        <c:choose>
            <c:when test="${! empty internalLinkNode}">
                <c:url var="linkUrl" value="${internalLinkNode.url}"/>
            </c:when>
        </c:choose>
    </c:when>
    <c:when test="${linkType eq 'externalLink'}">
        <c:url var="linkUrl" value="${currentNode.properties.externalLink.string}"/>
    </c:when>
    <c:when test="${linkType eq 'self'}">
        <c:url var="linkUrl" value="${currentNode.url}"/>
    </c:when>
</c:choose>

<div class="card border-0 rounded-0 text-light overflow zoom">
    <div class="position-relative">
        <!--thumbnail img-->
        <div class="ratio_left-cover-1 image-wrapper">
            <c:forEach items="${galleryImgs}" var="galImage" varStatus="status">
                <img class="img-fluid w-100" src="${galImage.node.url}" alt="${galImage.node.name}">
                </c:forEach>

        </div>
        <div class="position-absolute p-2 p-lg-3 b-0 w-100 bg-shadow">
            <!--title-->
            <a href="${linkUrl}">
                <h2 class="h3 post-title text-white my-1">${newsTitle}</h2>
            </a>
            <!-- meta title -->
            <div class="news-meta">
                Posted on <fmt:formatDate value="${newsDate.date.time}" pattern="dd/MM/yyyy"/>
            </div>
        </div>
    </div>
</div>

